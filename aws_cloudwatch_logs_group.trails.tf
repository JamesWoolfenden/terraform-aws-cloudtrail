resource "aws_cloudwatch_log_group" "trails" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days
  kms_key_id        = aws_kms_key.cloudtrail.arn

  # This log group holds the record of who did what in the account, including
  # the API calls that would delete it, and CloudWatch Logs has no undelete.
  # lifecycle.prevent_destroy is not a substitute: it only applies while the
  # resource block still exists in the configuration.
  deletion_protection_enabled = true
}
