variable "trail" {
  description = "Basic Settings for Cloudtrail"
  type        = map(any)
  default = {
    name                          = "tf-trail-account"
    s3_key_prefix                 = "prefix"
    include_global_service_events = false
  }
}


variable "enable_log_file_validation" {
  description = "Bool to enable log file validation"
  type        = bool
  default     = true
}

variable "enable_logging" {
  description = "Toggle logging"
  type        = bool
  default     = true
}

variable "is_multi_region_trail" {
  description = "Is this a multi-region trail? Secure option is default"
  type        = bool
  default     = true
}

variable "is_organization_trail" {
  description = "Is this for an organisation?"
  type        = bool
  default     = false
}
