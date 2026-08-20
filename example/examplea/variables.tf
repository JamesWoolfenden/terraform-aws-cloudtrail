variable "trail" {
  description = "Basic Settings for Cloudtrail"
  type        = map(any)

  validation {
    condition     = alltrue([for k in ["name", "s3_key_prefix", "include_global_service_events"] : contains(keys(var.trail), k)])
    error_message = "trail must define the keys name, s3_key_prefix and include_global_service_events."
  }
}
