output "service_account" {
  description = "The CloudTrail service account for the current region"
  value       = data.aws_cloudtrail_service_account.main
}
output "trail" {
  description = "The CloudTrail trail resource"
  value       = aws_cloudtrail.account
}
output "bucket" {
  description = "The S3 bucket holding the trail log files"
  value       = aws_s3_bucket.trails
}
output "kms" {
  description = "The KMS key encrypting the trail log files"
  value       = aws_kms_key.cloudtrail
}
output "log_group" {
  description = "The CloudWatch log group CloudTrail delivers events to"
  value       = aws_cloudwatch_log_group.trails
}
