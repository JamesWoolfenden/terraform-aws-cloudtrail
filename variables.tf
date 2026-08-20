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
  description = "Bucket receiving S3 server access logs for the trails bucket. Defaults to s3accesslogging-<account_id>, which must already exist"
  type        = string
  default     = null

  validation {
    condition     = var.access_log_bucket == null || can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.access_log_bucket))
    error_message = "access_log_bucket must be a valid S3 bucket name of 3-63 lowercase characters."
  }
}

variable "organization_id" {
  description = "AWS Organizations id (o-xxxxxxxxxx). Required when is_organization_trail is true, because an organization trail writes to AWSLogs/<org-id>/<account-id>/ rather than AWSLogs/<account-id>/"
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
