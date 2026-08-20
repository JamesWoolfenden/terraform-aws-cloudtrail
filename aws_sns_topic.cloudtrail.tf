resource "aws_sns_topic" "cloudtrail" {
  tags              = var.tags
  name_prefix       = "cloudtrail"
  kms_master_key_id = aws_kms_key.cloudtrail.arn
}

# CreateTrail rejects a trail whose SNS topic policy does not grant
# cloudtrail.amazonaws.com sns:Publish, and the default policy on a new topic
# grants only the owning account. SourceArn is built from its parts rather than
# from aws_cloudtrail.account.arn, which would invert the ordering the trail
# needs.
resource "aws_sns_topic_policy" "cloudtrail" {
  arn    = aws_sns_topic.cloudtrail.arn
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailSNSPolicy",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "sns:Publish",
            "Resource": "${aws_sns_topic.cloudtrail.arn}",
            "Condition": {
                "StringEquals": {
                    "aws:SourceArn": "${local.trail_arn}"
                }
            }
        }
    ]
}
POLICY
}
