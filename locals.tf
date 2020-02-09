
locals {
  trails_bucket = "trails-${data.aws_caller_identity.current.account_id}"
}
