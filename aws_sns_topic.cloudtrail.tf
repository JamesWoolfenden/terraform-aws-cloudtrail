resource "aws_sns_topic" "cloudtrail" {
  name_prefix       = "cloudtrail"
  kms_master_key_id = aws_kms_key.cloudtrail.arn
}
