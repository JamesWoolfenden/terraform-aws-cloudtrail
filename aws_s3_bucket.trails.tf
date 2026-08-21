# tfsec:ignore:AWS002
resource "aws_s3_bucket" "trails" {
  bucket = local.trails_bucket
  # Object Lock cannot coexist with force_destroy: locked objects cannot be
  # deleted, so a forced teardown would fail part-way through regardless.
  object_lock_enabled = true

  # Object Lock is a backstop, not a guarantee: retention runs 30 days from
  # each object's write, so a bucket the trail stopped writing to becomes
  # deletable, and GOVERNANCE mode yields to s3:BypassGovernanceRetention.
  # Matches the KMS key, which the bucket's contents are unreadable without.
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_policy" "trails" {
  bucket = aws_s3_bucket.trails.id
  policy = data.aws_iam_policy_document.trails.json
}

# A policy document rather than a JSON heredoc: the write statement's resource
# list varies with is_organization_trail, and interpolating a jsonencode() into
# a heredoc produces a document no static analyser can read -- it left the
# wildcard-principal and TLS checks permanently unevaluated.
data "aws_iam_policy_document" "trails" {
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:GetBucketAcl"]
    resources = ["arn:aws:s3:::${local.trails_bucket}"]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [local.trail_arn]
    }
  }

  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:PutObject"]
    resources = local.trail_write_resources

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [local.trail_arn]
    }
  }

  # The wildcard principal is deliberate and only reachable on a Deny: it is
  # what makes the TLS requirement apply to everyone rather than to a named set.
  statement {
    sid    = "DenyInsecureTransport"
    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:*"]
    resources = [
      "arn:aws:s3:::${local.trails_bucket}",
      "arn:aws:s3:::${local.trails_bucket}/*",
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "trails" {
  bucket = aws_s3_bucket.trails.id

  rule {
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
    status = "Enabled"
    id     = "delete after ${var.expiry} days"

    expiration {
      days                         = var.expiry
      expired_object_delete_marker = false
    }

    noncurrent_version_expiration {
      noncurrent_days = 31
    }

  }
}

# No aws_s3_bucket_acl here on purpose: buckets created since April 2023
# default to Object Ownership BucketOwnerEnforced, which disables ACLs and
# makes any aws_s3_bucket_acl fail with AccessControlListNotSupported. That
# default is already private, and aws_s3_bucket_public_access_block.trails
# covers the rest.
resource "aws_s3_bucket_logging" "trails" {
  bucket        = aws_s3_bucket.trails.id
  target_bucket = coalesce(var.access_log_bucket, local.logging.target_bucket)
  target_prefix = local.logging.target_prefix
}

resource "aws_s3_bucket_server_side_encryption_configuration" "trails" {
  bucket = aws_s3_bucket.trails.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.cloudtrail.arn
    }
  }

}

resource "aws_s3_bucket_versioning" "trails" {
  bucket = aws_s3_bucket.trails.id
  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }
}

# Object Lock only permits per-object locks until a default retention rule
# exists. GOVERNANCE (not COMPLIANCE) so an authorised principal can still
# correct a mistake, and 30 days sits well inside var.expiry so the lifecycle
# rule is never blocked from expiring an object it owns.
resource "aws_s3_bucket_object_lock_configuration" "trails" {
  bucket = aws_s3_bucket.trails.id

  rule {
    default_retention {
      mode = "GOVERNANCE"
      days = 30
    }
  }
}
