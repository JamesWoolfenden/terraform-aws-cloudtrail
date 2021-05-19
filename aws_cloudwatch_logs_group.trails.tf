resource "aws_cloudwatch_log_group" "trails" {
  name              = "cloudtrail"
  retention_in_days = var.retention_in_days
  kms_key_id        = aws_kms_key.cloudtrail.key_id
}


variable "retention_in_days" {
  type    = number
  default = 90
}
