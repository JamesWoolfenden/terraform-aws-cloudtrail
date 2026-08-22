trail = {
  name                          = "tf-trail-account"
  s3_key_prefix                 = "prefix"
  include_global_service_events = true
}

enable_cis_alarms = true
cis_alarm_period  = 300

# example.com is reserved for documentation, so this demonstrates the shape
# without addressing a real mailbox. A subscription is not active until its
# owner confirms it.
cis_alarm_subscriptions = [
  {
    protocol = "email"
    endpoint = "security-alerts@example.com"
  }
]
