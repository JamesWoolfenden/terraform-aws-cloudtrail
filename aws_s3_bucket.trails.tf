
resource "aws_s3_bucket" "trails" {
  bucket        = local.trails_bucket
  force_destroy = true
  acl           = "private"

  #checkov:skip=CKV_AWS_52: "Ensure S3 bucket has MFA delete enabled"
  versioning {
    enabled    = true
    mfa_delete = false
  }

  logging {
    target_bucket = local.logging["target_bucket"]
    target_prefix = local.logging["target_prefix"]
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
        #kms_master_key_id = aws_kms_key.trails.arn
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle {
    ignore_changes = [
      versioning["mfa_delete"]
    ]
  }

  tags = var.common_tags
}


variable "mfa_delete" {
  type        = bool
  description = "Terraform wont currently work with this set on, disabling by default with an ignore on changes"
}
