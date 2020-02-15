variable "common_tags" {
  description = "This is to help you add tags to your cloud objects"
  type        = map
}

variable "trail" {
description="Basic Settings for Cloudtrail"
  type = map
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
  description = ""
  type        = string
  default     = ""
}

variable "cloud_watch_logs_group_arn" {
  description = ""
  type        = string
  default     = ""
}
