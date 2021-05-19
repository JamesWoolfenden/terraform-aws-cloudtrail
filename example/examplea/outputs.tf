output "service_account" {
  value = module.cloudtrail.service_account
}

output "trail" {
  value = module.cloudtrail.trail
}

output "bucket" {
  value = module.cloudtrail.bucket
}

output "kms" {
  value = module.cloudtrail.kms
}


output "log_group" {
  value = module.cloudtrail.log_group
}
