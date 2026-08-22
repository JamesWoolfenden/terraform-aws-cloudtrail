# The last link in the chain. A metric filter with no alarm publishes a
# datapoint nobody reads; an alarm with no subscriber raises a notification
# nobody receives. Both leave a CIS control looking implemented to anything
# that only counts resources.
#
# Keyed by protocol and endpoint rather than by list index so that removing one
# subscription does not replace every subscription after it.
resource "aws_sns_topic_subscription" "cis_alarms" {
  for_each = var.enable_cis_alarms ? {
    for s in var.cis_alarm_subscriptions : "${s.protocol}:${s.endpoint}" => s
  } : {}

  topic_arn = aws_sns_topic.cis_alarms[0].arn
  protocol  = each.value.protocol
  endpoint  = each.value.endpoint
}
