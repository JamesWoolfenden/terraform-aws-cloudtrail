
resource "aws_cloudtrail" "account" {
  name                          = var.trail["name"]
  cloud_watch_logs_role_arn     = var.cloud_watch_logs_role_arn
  include_global_service_events = var.trail["include_global_service_events"]
  s3_bucket_name                = aws_s3_bucket.trails.id
  s3_key_prefix                 = var.trail["s3_key_prefix"]
  cloud_watch_logs_group_arn    = var.cloud_watch_logs_group_arn
  enable_log_file_validation    = var.enable_log_file_validation
  enable_logging                = var.enable_logging
  is_multi_region_trail         = false
  is_organization_trail         = false
  sns_topic_name                = var.sns_topic_name
  kms_key_id                    = aws_kms_key.cloudtrail.id
  depends_on                    = [aws_s3_bucket.trails]

  tags = var.common_tags
}
