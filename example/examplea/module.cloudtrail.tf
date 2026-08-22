# holden:ignore:HLD_TF_026: in-repo example, calls the module under test by relative path
module "cloudtrail" {
  source = "../../"
  trail  = var.trail

  # The CIS 3.1-3.14 filters and alarms are on by default; named here because
  # the example exists to show the module's surface, not just its defaults.
  enable_cis_alarms       = var.enable_cis_alarms
  cis_alarm_period        = var.cis_alarm_period
  cis_alarm_subscriptions = var.cis_alarm_subscriptions
}
