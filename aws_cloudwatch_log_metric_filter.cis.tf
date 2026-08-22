# holden:ignore:HLD_TF_025: the fourteen blocks are one CIS benchmark section, not fourteen unrelated resources; splitting them on a count threshold would hide the set rather than clarify it
# CIS AWS Foundations Benchmark section 3: the fourteen filters that turn the
# trail's CloudWatch Logs copy into detections. Written out one block per
# control rather than generated from a map on purpose -- the filter pattern is
# the control, so it stays a literal a reader (and a static analyser) can see.
# Their alarms are in aws_cloudwatch_metric_alarm.cis.tf.

resource "aws_cloudwatch_log_metric_filter" "unauthorized_api_calls" {
  count          = local.cis_count
  name           = "UnauthorizedAPICalls"
  log_group_name = aws_cloudwatch_log_group.trails.name
  pattern        = "{ ($.errorCode = \"*UnauthorizedOperation\") || ($.errorCode = \"AccessDenied*\") }"

  metric_transformation {
    name      = "UnauthorizedAPICalls"
    namespace = local.cis_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "console_signin_without_mfa" {
  count          = local.cis_count
  name           = "ConsoleSignInWithoutMFA"
  log_group_name = aws_cloudwatch_log_group.trails.name
  pattern        = "{ ($.eventName = \"ConsoleLogin\") && ($.additionalEventData.MFAUsed != \"Yes\") }"

  metric_transformation {
    name      = "ConsoleSignInWithoutMFA"
    namespace = local.cis_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "root_account_usage" {
  count          = local.cis_count
  name           = "RootAccountUsage"
  log_group_name = aws_cloudwatch_log_group.trails.name
  pattern        = "{ $.userIdentity.type = \"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType != \"AwsServiceEvent\" }"

  metric_transformation {
    name      = "RootAccountUsage"
    namespace = local.cis_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "iam_policy_changes" {
  count          = local.cis_count
  name           = "IAMPolicyChanges"
  log_group_name = aws_cloudwatch_log_group.trails.name
  pattern        = "{ ($.eventName = DeleteGroupPolicy) || ($.eventName = DeleteRolePolicy) || ($.eventName = DeleteUserPolicy) || ($.eventName = PutGroupPolicy) || ($.eventName = PutRolePolicy) || ($.eventName = PutUserPolicy) || ($.eventName = CreatePolicy) || ($.eventName = DeletePolicy) || ($.eventName = CreatePolicyVersion) || ($.eventName = DeletePolicyVersion) || ($.eventName = AttachRolePolicy) || ($.eventName = DetachRolePolicy) || ($.eventName = AttachUserPolicy) || ($.eventName = DetachUserPolicy) || ($.eventName = AttachGroupPolicy) || ($.eventName = DetachGroupPolicy) }"

  metric_transformation {
    name      = "IAMPolicyChanges"
    namespace = local.cis_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "cloudtrail_config_changes" {
  count          = local.cis_count
  name           = "CloudTrailConfigChanges"
  log_group_name = aws_cloudwatch_log_group.trails.name
  pattern        = "{ ($.eventName = CreateTrail) || ($.eventName = UpdateTrail) || ($.eventName = DeleteTrail) || ($.eventName = StartLogging) || ($.eventName = StopLogging) }"

  metric_transformation {
    name      = "CloudTrailConfigChanges"
    namespace = local.cis_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "console_auth_failures" {
  count          = local.cis_count
  name           = "ConsoleAuthenticationFailure"
  log_group_name = aws_cloudwatch_log_group.trails.name
  pattern        = "{ ($.eventName = ConsoleLogin) && ($.errorMessage = \"Failed authentication\") }"

  metric_transformation {
    name      = "ConsoleAuthenticationFailure"
    namespace = local.cis_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "disable_or_delete_cmk" {
  count          = local.cis_count
  name           = "DisableOrDeleteCMK"
  log_group_name = aws_cloudwatch_log_group.trails.name
  pattern        = "{ ($.eventSource = kms.amazonaws.com) && (($.eventName = DisableKey) || ($.eventName = ScheduleKeyDeletion)) }"

  metric_transformation {
    name      = "DisableOrDeleteCMK"
    namespace = local.cis_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "s3_bucket_policy_changes" {
  count          = local.cis_count
  name           = "S3BucketPolicyChanges"
  log_group_name = aws_cloudwatch_log_group.trails.name
  pattern        = "{ ($.eventSource = s3.amazonaws.com) && (($.eventName = PutBucketAcl) || ($.eventName = PutBucketPolicy) || ($.eventName = PutBucketCors) || ($.eventName = PutBucketLifecycle) || ($.eventName = PutBucketReplication) || ($.eventName = DeleteBucketPolicy) || ($.eventName = DeleteBucketCors) || ($.eventName = DeleteBucketLifecycle) || ($.eventName = DeleteBucketReplication)) }"

  metric_transformation {
    name      = "S3BucketPolicyChanges"
    namespace = local.cis_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "aws_config_changes" {
  count          = local.cis_count
  name           = "AWSConfigChanges"
  log_group_name = aws_cloudwatch_log_group.trails.name
  pattern        = "{ ($.eventSource = config.amazonaws.com) && (($.eventName = StopConfigurationRecorder) || ($.eventName = DeleteDeliveryChannel) || ($.eventName = PutDeliveryChannel) || ($.eventName = PutConfigurationRecorder)) }"

  metric_transformation {
    name      = "AWSConfigChanges"
    namespace = local.cis_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "security_group_changes" {
  count          = local.cis_count
  name           = "SecurityGroupChanges"
  log_group_name = aws_cloudwatch_log_group.trails.name
  pattern        = "{ ($.eventName = AuthorizeSecurityGroupIngress) || ($.eventName = AuthorizeSecurityGroupEgress) || ($.eventName = RevokeSecurityGroupIngress) || ($.eventName = RevokeSecurityGroupEgress) || ($.eventName = CreateSecurityGroup) || ($.eventName = DeleteSecurityGroup) }"

  metric_transformation {
    name      = "SecurityGroupChanges"
    namespace = local.cis_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "network_acl_changes" {
  count          = local.cis_count
  name           = "NetworkACLChanges"
  log_group_name = aws_cloudwatch_log_group.trails.name
  pattern        = "{ ($.eventName = CreateNetworkAcl) || ($.eventName = CreateNetworkAclEntry) || ($.eventName = DeleteNetworkAcl) || ($.eventName = DeleteNetworkAclEntry) || ($.eventName = ReplaceNetworkAclEntry) || ($.eventName = ReplaceNetworkAclAssociation) }"

  metric_transformation {
    name      = "NetworkACLChanges"
    namespace = local.cis_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "network_gateway_changes" {
  count          = local.cis_count
  name           = "NetworkGatewayChanges"
  log_group_name = aws_cloudwatch_log_group.trails.name
  pattern        = "{ ($.eventName = CreateCustomerGateway) || ($.eventName = DeleteCustomerGateway) || ($.eventName = AttachInternetGateway) || ($.eventName = CreateInternetGateway) || ($.eventName = DeleteInternetGateway) || ($.eventName = DetachInternetGateway) }"

  metric_transformation {
    name      = "NetworkGatewayChanges"
    namespace = local.cis_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "route_table_changes" {
  count          = local.cis_count
  name           = "RouteTableChanges"
  log_group_name = aws_cloudwatch_log_group.trails.name
  pattern        = "{ ($.eventName = CreateRoute) || ($.eventName = CreateRouteTable) || ($.eventName = ReplaceRoute) || ($.eventName = ReplaceRouteTableAssociation) || ($.eventName = DeleteRouteTable) || ($.eventName = DeleteRoute) || ($.eventName = DisassociateRouteTable) }"

  metric_transformation {
    name      = "RouteTableChanges"
    namespace = local.cis_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "vpc_changes" {
  count          = local.cis_count
  name           = "VPCChanges"
  log_group_name = aws_cloudwatch_log_group.trails.name
  pattern        = "{ ($.eventName = CreateVpc) || ($.eventName = DeleteVpc) || ($.eventName = ModifyVpcAttribute) || ($.eventName = AcceptVpcPeeringConnection) || ($.eventName = CreateVpcPeeringConnection) || ($.eventName = DeleteVpcPeeringConnection) || ($.eventName = RejectVpcPeeringConnection) || ($.eventName = AttachClassicLinkVpc) || ($.eventName = DetachClassicLinkVpc) || ($.eventName = DisableVpcClassicLink) || ($.eventName = EnableVpcClassicLink) }"

  metric_transformation {
    name      = "VPCChanges"
    namespace = local.cis_namespace
    value     = "1"
  }
}
