variable "common_tags" {
  description = "This is to help you add tags to your cloud objects"
  type        = map
}

variable "trail" {
  type = map
  default = {
    name                          = "tf-trail-account"
    s3_key_prefix                 = "prefix"
    include_global_service_events = false
  }
}
