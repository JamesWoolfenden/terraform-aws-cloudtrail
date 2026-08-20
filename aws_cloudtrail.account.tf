resource "aws_cloudtrail" "account" {
  name                          = var.trail["name"]
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail.arn
  enable_log_file_validation    = var.enable_log_file_validation
  enable_logging                = var.enable_logging
  include_global_service_events = var.trail["include_global_service_events"]
  is_multi_region_trail         = var.is_multi_region_trail
  is_organization_trail         = var.is_organization_trail
  kms_key_id                    = aws_kms_key.cloudtrail.arn
  s3_bucket_name                = aws_s3_bucket.trails.id
  s3_key_prefix                 = var.trail["s3_key_prefix"]
  sns_topic_name                = aws_sns_topic.cloudtrail.name
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.trails.arn}:*"

  # CreateTrail validates the SNS topic policy up front, and nothing in this
  # resource references the policy, so the ordering has to be explicit.
  depends_on = [aws_sns_topic_policy.cloudtrail]

  event_selector {
    read_write_type           = "All"
    include_management_events = true
  }
}

resource "aws_iam_role" "cloudtrail" {
  # Assumed only by the CloudTrail service for discrete per-delivery work, so
  # the AWS floor of one hour is all this role ever needs.
  max_session_duration = 3600

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "sts:AssumeRole",
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

resource "aws_iam_role_policy" "cloudtrail" {
  role   = aws_iam_role.cloudtrail.name
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {

      "Sid": "AWSCloudTrailCreateLogStream2014110",
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream"
      ],
      "Resource": [
        "arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:log-group:${var.log_group_name}:log-stream:*"
      ]

    },
    {
      "Sid": "AWSCloudTrailPutLogEvents20141101",
      "Effect": "Allow",
      "Action": [
        "logs:PutLogEvents"
      ],
      "Resource": [
        "arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:log-group:${var.log_group_name}:log-stream:*"
      ]
    }
  ]
}
POLICY
}
