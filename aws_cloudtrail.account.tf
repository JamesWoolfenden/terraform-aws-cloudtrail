
resource "aws_cloudtrail" "account" {
  name                          = var.trail["name"]
  cloud_watch_logs_group_arn    = var.cloud_watch_logs_group_arn
  cloud_watch_logs_role_arn     = var.cloud_watch_logs_role_arn
  depends_on                    = [aws_s3_bucket.trails]
  enable_log_file_validation    = true
  enable_logging                = var.enable_logging
  include_global_service_events = var.trail["include_global_service_events"]
  is_multi_region_trail         = var.is_multi_region_trail
  is_organization_trail         = var.is_organization_trail
  kms_key_id                    = aws_kms_key.cloudtrail.arn
  s3_bucket_name                = aws_s3_bucket.trails.id
  s3_key_prefix                 = var.trail["s3_key_prefix"]
  sns_topic_name                = var.sns_topic_name

  tags = var.common_tags
}
