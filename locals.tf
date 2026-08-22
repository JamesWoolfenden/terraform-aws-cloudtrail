locals {
  trails_bucket = "trails-${data.aws_caller_identity.current.account_id}"

  # An organization trail writes to AWSLogs/<org-id>/<account-id>/..., not
  # AWSLogs/<account-id>/.... The org id comes from a variable rather than
  # data.aws_organizations_organization, which errors for any account that
  # is not part of an organization.
  log_path_owner = var.is_organization_trail ? var.organization_id : data.aws_caller_identity.current.account_id

  # Built from its parts, never from aws_cloudtrail.account.arn: the SNS topic
  # policy and the bucket policy are both validated by CreateTrail, so making
  # them depend on the trail would invert the ordering they need.
  trail_arn = "arn:aws:cloudtrail:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:trail/${var.trail["name"]}"

  # AWS's reference policy for an organization trail grants both the account
  # path and the org path, so the management account's own logs still deliver.
  trail_write_resources = concat(
    ["arn:aws:s3:::${local.trails_bucket}/${var.trail["s3_key_prefix"]}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"],
    var.is_organization_trail ? ["arn:aws:s3:::${local.trails_bucket}/${var.trail["s3_key_prefix"]}/AWSLogs/${var.organization_id}/*"] : []
  )
  logging = {
    target_bucket = "s3accesslogging-${data.aws_caller_identity.current.account_id}"
    target_prefix = "trails"
  }
}

locals {
  # Every CIS 3.x metric filter and alarm hangs off this one count, so the
  # whole detection set turns on and off as a unit.
  cis_count = var.enable_cis_alarms ? 1 : 0

  # The namespace the filters publish into and the alarms read back from.
  cis_namespace = "CISBenchmark"
}
