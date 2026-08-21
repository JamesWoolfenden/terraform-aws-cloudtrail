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
output "cis_alarm_topic" {
  description = "The SNS topic the CIS 3.1-3.14 alarms notify. Null when enable_cis_alarms is false. Subscribe to it: an alarm with no subscriber is not a detection"
  value       = one(aws_sns_topic.cis_alarms)
}
