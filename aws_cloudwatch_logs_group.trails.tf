resource "aws_cloudwatch_log_group" "trails" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days
  kms_key_id        = aws_kms_key.cloudtrail.arn
}
