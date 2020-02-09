output "service_account" {
  value = module.cloudtrail.service_account
}

output "trail" {
  value = module.cloudtrail.trail
}

output "bucket" {
  value = module.cloudtrail.bucket
}

output "key" {
  value = module.cloudtrail.key
}
