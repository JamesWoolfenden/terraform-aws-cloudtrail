# tfsec:ignore:AWS002
resource "aws_s3_bucket" "trails" {
  bucket = local.trails_bucket
  # Object Lock cannot coexist with force_destroy: locked objects cannot be
  # deleted, so a forced teardown would fail part-way through regardless.
  object_lock_enabled = true
}

resource "aws_s3_bucket_policy" "trails" {
  bucket = aws_s3_bucket.trails.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::${local.trails_bucket}",
            "Condition": {
                "StringEquals": {
                    "aws:SourceArn": "${local.trail_arn}"
                }
            }
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": ${local.trail_write_resources},
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control",
                    "aws:SourceArn": "${local.trail_arn}"
                }
            }
        },
        {
            "Sid": "DenyInsecureTransport",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${local.trails_bucket}",
                "arn:aws:s3:::${local.trails_bucket}/*"
            ],
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            }
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_lifecycle_configuration" "trails" {
  bucket = aws_s3_bucket.trails.id

  rule {
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
    status = "Enabled"
    id     = "delete after ${var.expiry} days"

    expiration {
      days                         = var.expiry
      expired_object_delete_marker = false
    }

    noncurrent_version_expiration {
      noncurrent_days = 31
    }

  }
}

# No aws_s3_bucket_acl here on purpose: buckets created since April 2023
# default to Object Ownership BucketOwnerEnforced, which disables ACLs and
# makes any aws_s3_bucket_acl fail with AccessControlListNotSupported. That
# default is already private, and aws_s3_bucket_public_access_block.trails
# covers the rest.
resource "aws_s3_bucket_logging" "trails" {
  bucket        = aws_s3_bucket.trails.id
  target_bucket = coalesce(var.access_log_bucket, local.logging.target_bucket)
  target_prefix = local.logging.target_prefix
}

resource "aws_s3_bucket_server_side_encryption_configuration" "trails" {
  bucket = aws_s3_bucket.trails.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.cloudtrail.arn
    }
  }

}

resource "aws_s3_bucket_versioning" "trails" {
  bucket = aws_s3_bucket.trails.id
  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }
}

# Object Lock only permits per-object locks until a default retention rule
# exists. GOVERNANCE (not COMPLIANCE) so an authorised principal can still
# correct a mistake, and 30 days sits well inside var.expiry so the lifecycle
# rule is never blocked from expiring an object it owns.
resource "aws_s3_bucket_object_lock_configuration" "trails" {
  bucket = aws_s3_bucket.trails.id

  rule {
    default_retention {
      mode = "GOVERNANCE"
      days = 30
    }
  }
}
