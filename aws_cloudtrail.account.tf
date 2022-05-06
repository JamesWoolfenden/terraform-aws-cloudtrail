
resource "aws_cloudtrail" "account" {
  name                          = var.trail["name"]
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail.arn
  depends_on                    = [aws_s3_bucket.trails]
  enable_log_file_validation    = true
  enable_logging                = var.enable_logging
  include_global_service_events = var.trail["include_global_service_events"]
  is_multi_region_trail         = var.is_multi_region_trail
  is_organization_trail         = var.is_organization_trail
  kms_key_id                    = aws_kms_key.cloudtrail.arn
  s3_bucket_name                = aws_s3_bucket.trails.id
  s3_key_prefix                 = var.trail["s3_key_prefix"]
  sns_topic_name                = aws_sns_topic.cloudtrail.name
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.trails.arn}:*"
}


resource "aws_iam_role" "cloudtrail" {
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
      "Action": "sts:AssumeRole"
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
        "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${var.log_group_name}:log-stream:*"
      ]

    },
    {
      "Sid": "AWSCloudTrailPutLogEvents20141101",
      "Effect": "Allow",
      "Action": [
        "logs:PutLogEvents"
      ],
      "Resource": [
        "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${var.log_group_name}:log-stream:*"
      ]
    }
  ]
}
POLICY
}
