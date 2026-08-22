output "service_account" {
  description = "The CloudTrail service account for the current region"
  value       = module.cloudtrail.service_account
}
output "trail" {
  description = "The CloudTrail trail resource"
  value       = module.cloudtrail.trail
}
output "bucket" {
  description = "The S3 bucket holding the trail log files"
  value       = module.cloudtrail.bucket
}
output "kms" {
  description = "The KMS key encrypting the trail log files"
  value       = module.cloudtrail.kms
}
output "log_group" {
  description = "The CloudWatch log group CloudTrail delivers events to"
  value       = module.cloudtrail.log_group
}
output "cis_alarm_topic" {
  description = "The SNS topic the CIS 3.1-3.14 alarms notify"
  value       = module.cloudtrail.cis_alarm_topic
}
output "cis_alarm_subscriptions" {
  description = "The subscriptions attached to the CIS alarm topic"
  value       = module.cloudtrail.cis_alarm_subscriptions
}
