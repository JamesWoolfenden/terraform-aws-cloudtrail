
# tfsec:ignore:AWS002
resource "aws_s3_bucket" "trails" {
  # checkov:skip=CKV_AWS_144: ADD REASON
  # checkov:skip=CKV_AWS_52: "Ensure S3 bucket has MFA delete enabled"
  # checkov:skip=CKV_AWS_18: "Ensure the S3 bucket has access logging enabled"
  bucket        = local.trails_bucket
  force_destroy = true
  acl           = "private"


  versioning {
    enabled    = true
    mfa_delete = var.mfa_delete
  }

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
            "Resource": "arn:aws:s3:::${local.trails_bucket}/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.cloudtrail.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
  lifecycle_rule {
    abort_incomplete_multipart_upload_days = 0
    enabled                                = true
    id                                     = "delete after ${var.expiry} days"

    expiration {
      days                         = var.expiry
      expired_object_delete_marker = false
    }

    noncurrent_version_expiration {
      days = 1
    }
  }
  lifecycle {
    ignore_changes = [
      versioning["mfa_delete"]
    ]
  }
}


variable "expiry" {
  type        = number
  default     = 30
  description = "Expire logs after this many days"
}

variable "mfa_delete" {
  type        = bool
  description = "Terraform wont currently work with this set on, disabling by default with an ignore on changes"
  default     = false
}
