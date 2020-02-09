
resource "aws_cloudtrail" "account" {
  name                          = var.trail["name"]
  cloud_watch_logs_role_arn     = ""
  include_global_service_events = var.trail["include_global_service_events"]
  s3_bucket_name                = aws_s3_bucket.trails.id
  s3_key_prefix                 = var.trail["s3_key_prefix"]
  cloud_watch_logs_group_arn    = ""
  enable_log_file_validation    = true
  enable_logging                = true
  is_multi_region_trail         = false
  is_organization_trail         = false
  kms_key_id                    = aws_kms_key.trails.arn
  sns_topic_name                = ""

  tags = var.common_tags
}
