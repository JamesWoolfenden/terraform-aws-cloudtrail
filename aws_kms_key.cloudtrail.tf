resource "aws_kms_key" "cloudtrail" {
  enable_key_rotation = true
}
