variable "trail" {
  description = "Basic Settings for Cloudtrail"
  type        = map(any)
  default = {
    name                          = "tf-trail-account"
    s3_key_prefix                 = "prefix"
    include_global_service_events = true
  }

  validation {
    condition     = alltrue([for k in ["name", "s3_key_prefix", "include_global_service_events"] : contains(keys(var.trail), k)])
    error_message = "trail must define the keys name, s3_key_prefix and include_global_service_events."
  }

  validation {
    condition     = can(regex("^[0-9A-Za-z][0-9A-Za-z._-]{2,127}$", var.trail["name"]))
    error_message = "trail[\"name\"] must be 3-128 characters of letters, numbers, periods, underscores or hyphens, starting with a letter or number."
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

variable "log_group_name" {
  description = "Name of the CloudWatch log group CloudTrail delivers events to"
  type        = string
  default     = "cloudtrail"

  validation {
    condition     = can(regex("^[0-9A-Za-z_./#-]{1,512}$", var.log_group_name))
    error_message = "log_group_name must be 1-512 characters of letters, numbers, underscores, hyphens, forward slashes, periods or hash signs."
  }
}

variable "retention_in_days" {
  description = "Days to retain events in the CloudWatch log group. 0 retains them indefinitely"
  type        = number
  default     = 365

  validation {
    condition     = contains([0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653], var.retention_in_days)
    error_message = "retention_in_days must be one of the values CloudWatch Logs accepts: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288 or 3653."
  }
}

variable "expiry" {
  description = "Expire logs after this many days. Matches retention_in_days so the S3 and CloudWatch copies of the trail age out together"
  type        = number
  default     = 365

  validation {
    condition     = var.expiry >= 1 && var.expiry <= 3650
    error_message = "expiry must be between 1 and 3650 days."
  }
}


variable "access_log_bucket" {
  description = "Bucket receiving S3 server access logs for the trails bucket. Defaults to s3accesslogging-ACCOUNT_ID, which must already exist"
  type        = string
  default     = null

  validation {
    condition     = var.access_log_bucket == null || can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.access_log_bucket))
    error_message = "access_log_bucket must be a valid S3 bucket name of 3-63 lowercase characters."
  }
}

variable "organization_id" {
  description = "AWS Organizations id (o-xxxxxxxxxx). Required when is_organization_trail is true, because an organization trail writes to AWSLogs/ORG_ID/ACCOUNT_ID/ rather than AWSLogs/ACCOUNT_ID/"
  type        = string
  default     = null

  validation {
    condition     = var.organization_id == null || can(regex("^o-[a-z0-9]{10,32}$", var.organization_id))
    error_message = "organization_id must look like o-xxxxxxxxxx."
  }

  validation {
    condition     = !var.is_organization_trail || var.organization_id != null
    error_message = "organization_id must be set when is_organization_trail is true, or CloudTrail cannot deliver to the bucket."
  }
}

variable "enable_cis_alarms" {
  description = "Create the CIS 3.1-3.14 metric filters and alarms on the trail's log group, and the SNS topic they notify. Turn off where alarming is handled centrally rather than per trail"
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
  description = "Subscriptions to attach to the CIS alarm topic, as protocol/endpoint pairs. Empty by default because an endpoint is the consumer's to choose, but an alarm topic with no subscriber is not a detection"
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
    error_message = "cis_alarm_subscriptions protocol must be one of email, email-json, sms, sqs, https, lambda, application or firehose. Note http is absent: the topic carries security alerts and must not be delivered in clear text."
  }

  validation {
    condition = alltrue([
      for s in var.cis_alarm_subscriptions : length(trimspace(s.endpoint)) > 0
    ])
    error_message = "cis_alarm_subscriptions endpoint must not be empty."
  }

  validation {
    condition     = var.enable_cis_alarms || length(var.cis_alarm_subscriptions) == 0
    error_message = "cis_alarm_subscriptions has no effect while enable_cis_alarms is false, and would silently subscribe nothing. Enable the alarms or drop the subscriptions."
  }
}
