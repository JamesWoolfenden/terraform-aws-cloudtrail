# Deliberately not aws_sns_topic.cloudtrail: that topic carries one
# notification per log file delivered, so a subscription useful for security
# alerts would be buried under delivery noise.
resource "aws_sns_topic" "cis_alarms" {
  count             = local.cis_count
  name_prefix       = "cloudtrail-cis-alarms"
  kms_master_key_id = aws_kms_key.cloudtrail.arn
}

# CloudWatch publishes as a service principal, which the key policy's
# account-root statement does not cover, and the default topic policy grants
# only the owning account.
resource "aws_sns_topic_policy" "cis_alarms" {
  count  = local.cis_count
  arn    = aws_sns_topic.cis_alarms[0].arn
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowCloudWatchAlarmsToPublish",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudwatch.amazonaws.com"
            },
            "Action": "sns:Publish",
            "Resource": "${aws_sns_topic.cis_alarms[0].arn}",
            "Condition": {
                "StringEquals": {
                    "aws:SourceAccount": "${data.aws_caller_identity.current.account_id}"
                }
            }
        }
    ]
}
POLICY
}
