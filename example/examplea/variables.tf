variable "trail" {
  description = "Basic Settings for Cloudtrail"
  type        = map(any)

  validation {
    condition     = alltrue([for k in ["name", "s3_key_prefix", "include_global_service_events"] : contains(keys(var.trail), k)])
    error_message = "trail must define the keys name, s3_key_prefix and include_global_service_events."
  }
}

variable "enable_cis_alarms" {
  description = "Create the CIS 3.1-3.14 metric filters and alarms"
  type        = bool
  default     = true
}

variable "cis_alarm_period" {
  description = "Seconds each CIS alarm aggregates its metric over before evaluating"
  type        = number
  default     = 300

  validation {
    condition     = contains([10, 30, 60, 300, 900, 3600], var.cis_alarm_period)
    error_message = "cis_alarm_period must be one of the periods CloudWatch accepts: 10, 30, 60, 300, 900 or 3600."
  }
}

variable "cis_alarm_subscriptions" {
  description = "Subscriptions to attach to the CIS alarm topic, as protocol/endpoint pairs"
  type = list(object({
    protocol = string
    endpoint = string
  }))
  default = []

  validation {
    condition = alltrue([
      for s in var.cis_alarm_subscriptions :
      contains(["email", "email-json", "sms", "sqs", "https", "lambda", "application", "firehose"], s.protocol)
    ])
    error_message = "cis_alarm_subscriptions protocol must be one of email, email-json, sms, sqs, https, lambda, application or firehose."
  }
}
