# holden:ignore:HLD_TF_025: the fourteen blocks are one CIS benchmark section, not fourteen unrelated resources; splitting them on a count threshold would hide the set rather than clarify it
# The alarm half of CIS section 3. A metric filter on its own publishes a
# datapoint nobody reads -- the control is only satisfied once an alarm on that
# metric notifies a topic with a subscriber. Every alarm here treats missing
# data as not breaching: these metrics only emit when the event happens, so the
# normal state is no datapoints at all.

resource "aws_cloudwatch_metric_alarm" "unauthorized_api_calls" {
  count                     = local.cis_count
  alarm_name                = "cis-3.1-unauthorized-api-calls"
  alarm_description         = "CIS 3.1: an API call was rejected as unauthorized or access denied"
  metric_name               = aws_cloudwatch_log_metric_filter.unauthorized_api_calls[0].metric_transformation[0].name
  namespace                 = local.cis_namespace
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  period                    = var.cis_alarm_period
  statistic                 = "Sum"
  threshold                 = 1
  treat_missing_data        = "notBreaching"
  actions_enabled           = true
  alarm_actions             = [aws_sns_topic.cis_alarms[0].arn]
  ok_actions                = [aws_sns_topic.cis_alarms[0].arn]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_metric_alarm" "console_signin_without_mfa" {
  count                     = local.cis_count
  alarm_name                = "cis-3.2-console-signin-without-mfa"
  alarm_description         = "CIS 3.2: a console sign-in completed without MFA"
  metric_name               = aws_cloudwatch_log_metric_filter.console_signin_without_mfa[0].metric_transformation[0].name
  namespace                 = local.cis_namespace
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  period                    = var.cis_alarm_period
  statistic                 = "Sum"
  threshold                 = 1
  treat_missing_data        = "notBreaching"
  actions_enabled           = true
  alarm_actions             = [aws_sns_topic.cis_alarms[0].arn]
  ok_actions                = [aws_sns_topic.cis_alarms[0].arn]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_metric_alarm" "root_account_usage" {
  count                     = local.cis_count
  alarm_name                = "cis-3.3-root-account-usage"
  alarm_description         = "CIS 3.3: the root account was used"
  metric_name               = aws_cloudwatch_log_metric_filter.root_account_usage[0].metric_transformation[0].name
  namespace                 = local.cis_namespace
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  period                    = var.cis_alarm_period
  statistic                 = "Sum"
  threshold                 = 1
  treat_missing_data        = "notBreaching"
  actions_enabled           = true
  alarm_actions             = [aws_sns_topic.cis_alarms[0].arn]
  ok_actions                = [aws_sns_topic.cis_alarms[0].arn]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_metric_alarm" "iam_policy_changes" {
  count                     = local.cis_count
  alarm_name                = "cis-3.4-iam-policy-changes"
  alarm_description         = "CIS 3.4: an IAM policy was created, deleted, attached or detached"
  metric_name               = aws_cloudwatch_log_metric_filter.iam_policy_changes[0].metric_transformation[0].name
  namespace                 = local.cis_namespace
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  period                    = var.cis_alarm_period
  statistic                 = "Sum"
  threshold                 = 1
  treat_missing_data        = "notBreaching"
  actions_enabled           = true
  alarm_actions             = [aws_sns_topic.cis_alarms[0].arn]
  ok_actions                = [aws_sns_topic.cis_alarms[0].arn]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_metric_alarm" "cloudtrail_config_changes" {
  count                     = local.cis_count
  alarm_name                = "cis-3.5-cloudtrail-config-changes"
  alarm_description         = "CIS 3.5: a trail was created, updated, deleted, started or stopped"
  metric_name               = aws_cloudwatch_log_metric_filter.cloudtrail_config_changes[0].metric_transformation[0].name
  namespace                 = local.cis_namespace
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  period                    = var.cis_alarm_period
  statistic                 = "Sum"
  threshold                 = 1
  treat_missing_data        = "notBreaching"
  actions_enabled           = true
  alarm_actions             = [aws_sns_topic.cis_alarms[0].arn]
  ok_actions                = [aws_sns_topic.cis_alarms[0].arn]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_metric_alarm" "console_auth_failures" {
  count                     = local.cis_count
  alarm_name                = "cis-3.6-console-authentication-failures"
  alarm_description         = "CIS 3.6: a console sign-in failed authentication"
  metric_name               = aws_cloudwatch_log_metric_filter.console_auth_failures[0].metric_transformation[0].name
  namespace                 = local.cis_namespace
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  period                    = var.cis_alarm_period
  statistic                 = "Sum"
  threshold                 = 1
  treat_missing_data        = "notBreaching"
  actions_enabled           = true
  alarm_actions             = [aws_sns_topic.cis_alarms[0].arn]
  ok_actions                = [aws_sns_topic.cis_alarms[0].arn]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_metric_alarm" "disable_or_delete_cmk" {
  count                     = local.cis_count
  alarm_name                = "cis-3.7-disable-or-delete-cmk"
  alarm_description         = "CIS 3.7: a KMS customer managed key was disabled or scheduled for deletion"
  metric_name               = aws_cloudwatch_log_metric_filter.disable_or_delete_cmk[0].metric_transformation[0].name
  namespace                 = local.cis_namespace
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  period                    = var.cis_alarm_period
  statistic                 = "Sum"
  threshold                 = 1
  treat_missing_data        = "notBreaching"
  actions_enabled           = true
  alarm_actions             = [aws_sns_topic.cis_alarms[0].arn]
  ok_actions                = [aws_sns_topic.cis_alarms[0].arn]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_metric_alarm" "s3_bucket_policy_changes" {
  count                     = local.cis_count
  alarm_name                = "cis-3.8-s3-bucket-policy-changes"
  alarm_description         = "CIS 3.8: an S3 bucket policy or ACL was changed"
  metric_name               = aws_cloudwatch_log_metric_filter.s3_bucket_policy_changes[0].metric_transformation[0].name
  namespace                 = local.cis_namespace
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  period                    = var.cis_alarm_period
  statistic                 = "Sum"
  threshold                 = 1
  treat_missing_data        = "notBreaching"
  actions_enabled           = true
  alarm_actions             = [aws_sns_topic.cis_alarms[0].arn]
  ok_actions                = [aws_sns_topic.cis_alarms[0].arn]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_metric_alarm" "aws_config_changes" {
  count                     = local.cis_count
  alarm_name                = "cis-3.9-aws-config-changes"
  alarm_description         = "CIS 3.9: an AWS Config recorder or delivery channel was changed"
  metric_name               = aws_cloudwatch_log_metric_filter.aws_config_changes[0].metric_transformation[0].name
  namespace                 = local.cis_namespace
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  period                    = var.cis_alarm_period
  statistic                 = "Sum"
  threshold                 = 1
  treat_missing_data        = "notBreaching"
  actions_enabled           = true
  alarm_actions             = [aws_sns_topic.cis_alarms[0].arn]
  ok_actions                = [aws_sns_topic.cis_alarms[0].arn]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_metric_alarm" "security_group_changes" {
  count                     = local.cis_count
  alarm_name                = "cis-3.10-security-group-changes"
  alarm_description         = "CIS 3.10: a security group or one of its rules was changed"
  metric_name               = aws_cloudwatch_log_metric_filter.security_group_changes[0].metric_transformation[0].name
  namespace                 = local.cis_namespace
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  period                    = var.cis_alarm_period
  statistic                 = "Sum"
  threshold                 = 1
  treat_missing_data        = "notBreaching"
  actions_enabled           = true
  alarm_actions             = [aws_sns_topic.cis_alarms[0].arn]
  ok_actions                = [aws_sns_topic.cis_alarms[0].arn]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_metric_alarm" "network_acl_changes" {
  count                     = local.cis_count
  alarm_name                = "cis-3.11-network-acl-changes"
  alarm_description         = "CIS 3.11: a network ACL or one of its entries was changed"
  metric_name               = aws_cloudwatch_log_metric_filter.network_acl_changes[0].metric_transformation[0].name
  namespace                 = local.cis_namespace
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  period                    = var.cis_alarm_period
  statistic                 = "Sum"
  threshold                 = 1
  treat_missing_data        = "notBreaching"
  actions_enabled           = true
  alarm_actions             = [aws_sns_topic.cis_alarms[0].arn]
  ok_actions                = [aws_sns_topic.cis_alarms[0].arn]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_metric_alarm" "network_gateway_changes" {
  count                     = local.cis_count
  alarm_name                = "cis-3.12-network-gateway-changes"
  alarm_description         = "CIS 3.12: a customer or internet gateway was created, deleted, attached or detached"
  metric_name               = aws_cloudwatch_log_metric_filter.network_gateway_changes[0].metric_transformation[0].name
  namespace                 = local.cis_namespace
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  period                    = var.cis_alarm_period
  statistic                 = "Sum"
  threshold                 = 1
  treat_missing_data        = "notBreaching"
  actions_enabled           = true
  alarm_actions             = [aws_sns_topic.cis_alarms[0].arn]
  ok_actions                = [aws_sns_topic.cis_alarms[0].arn]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_metric_alarm" "route_table_changes" {
  count                     = local.cis_count
  alarm_name                = "cis-3.13-route-table-changes"
  alarm_description         = "CIS 3.13: a route table or one of its routes was changed"
  metric_name               = aws_cloudwatch_log_metric_filter.route_table_changes[0].metric_transformation[0].name
  namespace                 = local.cis_namespace
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  period                    = var.cis_alarm_period
  statistic                 = "Sum"
  threshold                 = 1
  treat_missing_data        = "notBreaching"
  actions_enabled           = true
  alarm_actions             = [aws_sns_topic.cis_alarms[0].arn]
  ok_actions                = [aws_sns_topic.cis_alarms[0].arn]
  insufficient_data_actions = []
}

resource "aws_cloudwatch_metric_alarm" "vpc_changes" {
  count                     = local.cis_count
  alarm_name                = "cis-3.14-vpc-changes"
  alarm_description         = "CIS 3.14: a VPC, VPC attribute or VPC peering connection was changed"
  metric_name               = aws_cloudwatch_log_metric_filter.vpc_changes[0].metric_transformation[0].name
  namespace                 = local.cis_namespace
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  period                    = var.cis_alarm_period
  statistic                 = "Sum"
  threshold                 = 1
  treat_missing_data        = "notBreaching"
  actions_enabled           = true
  alarm_actions             = [aws_sns_topic.cis_alarms[0].arn]
  ok_actions                = [aws_sns_topic.cis_alarms[0].arn]
  insufficient_data_actions = []
}
