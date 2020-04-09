
locals {
  trails_bucket = "trails-${data.aws_caller_identity.current.account_id}"
  logging = {
    target_bucket = "s3accesslogging-${data.aws_caller_identity.current.account_id}"
    target_prefix = "trails"
  }
}
