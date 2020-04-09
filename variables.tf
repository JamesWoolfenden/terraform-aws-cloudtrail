variable "common_tags" {
  description = "This is to help you add tags to your cloud objects"
  type        = map
}

variable "trail" {
  description = "Basic Settings for Cloudtrail"
  type        = map
  default = {
    name                          = "tf-trail-account"
    s3_key_prefix                 = "prefix"
    include_global_service_events = false
  }
}

variable "sns_topic_name" {
  description = ""
  type        = string
  default     = ""
}

variable "cloud_watch_logs_role_arn" {
  description = "Role ARN for Cloudwatch logs"
  type        = string
  default     = ""
}

variable "cloud_watch_logs_group_arn" {
  description = "ARN for Cloudwatch logs group"
  type        = string
  default     = ""
}

variable "enable_log_file_validation" {
  description = "Bool to enable log file validation"
  type        = bool
  default     = true
}

variable "enable_logging" {
  type    = bool
  default = true
}

variable "is_multi_region_trail" {
  description = "Is this a multiregion trail?"
  type        = bool
  default     = false
}

variable "is_organization_trail" {
  description = "Is this for an organisation?"
  type        = bool
  default     = false
}
