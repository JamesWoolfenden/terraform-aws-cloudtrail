
# tfsec:ignore:AWS002
resource "aws_s3_bucket" "trails" {
  # checkov:skip=CKV_AWS_144: ADD REASON
  # checkov:skip=CKV_AWS_52: "Ensure S3 bucket has MFA delete enabled"
  # checkov:skip=CKV_AWS_18: "Ensure the S3 bucket has access logging enabled"
  # checkov:skip=CKV2_AWS_41: skip logging
  # checkov:skip=CKV_AWS_145: v4 legacy
  # checkov:skip=CKV_AWS_19: v4 legacy
  # checkov:skip=CKV_AWS_21: v4 legacy
  bucket        = local.trails_bucket
  force_destroy = true
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
            "Resource": "arn:aws:s3:::${local.trails_bucket}"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${local.trails_bucket}/${var.trail["s3_key_prefix"]}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
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


resource "aws_s3_bucket_acl" "trails" {
  bucket = aws_s3_bucket.trails.bucket
  acl    = "private"
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



variable "expiry" {
  type        = number
  default     = 30
  description = "Expire logs after this many days"
}
