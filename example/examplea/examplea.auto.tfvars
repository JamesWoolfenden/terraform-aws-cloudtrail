common_tags = {
  "createdby" = "Terraform"
module = "terraform-aws-cloudtrail" }
trail = {
  name                          = "tf-trail-account"
  s3_key_prefix                 = "prefix"
  include_global_service_events = true
}
