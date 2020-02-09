output "service_account" {
  value = data.aws_cloudtrail_service_account.main
}

output "trail" {
  value = aws_cloudtrail.account
}

output "bucket" {
  value = aws_s3_bucket.trails
}

output "key" {
  value = aws_kms_key.trails
}
