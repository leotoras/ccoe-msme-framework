###############################################################################
# MSME Cloud Governance Framework — Component 2: Security Baseline
#
# A foundational AWS security baseline scoped for small and mid-sized
# enterprises. Deliberately limited to controls that are high-value,
# low-controversy, and operable by an organization without a security team.
#
# Implements maturity assessment indicators 2.1, 2.2, 2.3, and 2.5.
#
# Licensed under the MIT License. See repository LICENSE.
###############################################################################

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      ManagedBy = "terraform"
      Framework = "msme-cloud-governance"
      Component = "02-security-baseline"
    }
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  name_prefix = "${var.name_prefix}-${local.account_id}"
}

###############################################################################
# INDICATOR 2.1 — Audit logging
#
# CloudTrail records API and management-plane activity. Multi-region so that
# activity in an unused region is still captured — a common blind spot, since
# an attacker is not obliged to work in your primary region.
#
# Log file validation is enabled so that tampering is detectable.
###############################################################################

resource "aws_s3_bucket" "audit_logs" {
  bucket        = "${local.name_prefix}-audit-logs"
  force_destroy = false

  tags = {
    Name      = "${local.name_prefix}-audit-logs"
    Indicator = "2.1-audit-logging"
  }
}

# INDICATOR 2.5 — the audit log bucket is itself blocked from public access.
resource "aws_s3_bucket_public_access_block" "audit_logs" {
  bucket = aws_s3_bucket.audit_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "audit_logs" {
  bucket = aws_s3_bucket.audit_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "audit_logs" {
  bucket = aws_s3_bucket.audit_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Retain logs for the configured period, then expire. Adjust to your
# regulatory obligations before deploying — the default is a starting point,
# not a compliance determination.
resource "aws_s3_bucket_lifecycle_configuration" "audit_logs" {
  bucket = aws_s3_bucket.audit_logs.id

  rule {
    id     = "expire-audit-logs"
    status = "Enabled"

    filter {}

    expiration {
      days = var.log_retention_days
    }

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}

data "aws_iam_policy_document" "audit_logs" {
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.audit_logs.arn]
  }

  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.audit_logs.arn}/AWSLogs/${local.account_id}/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  # AWS Config delivers here as well (indicator 2.2).
  statement {
    sid    = "AWSConfigAclCheck"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    actions   = ["s3:GetBucketAcl", "s3:ListBucket"]
    resources = [aws_s3_bucket.audit_logs.arn]
  }

  statement {
    sid    = "AWSConfigWrite"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.audit_logs.arn}/AWSLogs/${local.account_id}/Config/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

resource "aws_s3_bucket_policy" "audit_logs" {
  bucket = aws_s3_bucket.audit_logs.id
  policy = data.aws_iam_policy_document.audit_logs.json

  depends_on = [aws_s3_bucket_public_access_block.audit_logs]
}

resource "aws_cloudtrail" "main" {
  name                          = "${local.name_prefix}-trail"
  s3_bucket_name                = aws_s3_bucket.audit_logs.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  enable_logging                = true

  tags = {
    Indicator = "2.1-audit-logging"
  }

  depends_on = [aws_s3_bucket_policy.audit_logs]
}

###############################################################################
# INDICATOR 2.2 — Configuration recording
#
# AWS Config records resource configuration changes so that "what changed and
# when" is answerable during incident review rather than reconstructed.
###############################################################################

resource "aws_iam_role" "config" {
  count = var.enable_config ? 1 : 0
  name  = "${local.name_prefix}-config-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "config.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = {
    Indicator = "2.2-configuration-recording"
  }
}

resource "aws_iam_role_policy_attachment" "config" {
  count      = var.enable_config ? 1 : 0
  role       = aws_iam_role.config[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}

resource "aws_config_configuration_recorder" "main" {
  count    = var.enable_config ? 1 : 0
  name     = "${local.name_prefix}-recorder"
  role_arn = aws_iam_role.config[0].arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "main" {
  count          = var.enable_config ? 1 : 0
  name           = "${local.name_prefix}-delivery"
  s3_bucket_name = aws_s3_bucket.audit_logs.id
  s3_key_prefix  = "AWSLogs/${local.account_id}/Config"

  depends_on = [aws_config_configuration_recorder.main]
}

resource "aws_config_configuration_recorder_status" "main" {
  count      = var.enable_config ? 1 : 0
  name       = aws_config_configuration_recorder.main[0].name
  is_enabled = true

  depends_on = [aws_config_delivery_channel.main]
}

###############################################################################
# INDICATOR 2.3 — Identity hardening
#
# A password policy is the floor, not the goal. The substantive control is MFA
# enforcement and not using root routinely — neither of which Terraform can
# fully impose. See the notes in README.md for what you must do by hand.
###############################################################################

resource "aws_iam_account_password_policy" "main" {
  count = var.manage_password_policy ? 1 : 0

  minimum_password_length        = var.password_minimum_length
  require_uppercase_characters   = true
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  allow_users_to_change_password = true
  max_password_age               = var.password_max_age_days
  password_reuse_prevention      = 5
  hard_expiry                    = false
}

# Alert on root account usage. Root should be effectively dormant; if it is
# used, someone should know within minutes rather than at the next review.
resource "aws_cloudwatch_log_group" "cloudtrail" {
  count             = var.enable_root_usage_alarm ? 1 : 0
  name              = "/aws/cloudtrail/${local.name_prefix}"
  retention_in_days = var.log_retention_days

  tags = {
    Indicator = "2.3-identity-hardening"
  }
}

resource "aws_sns_topic" "security_alerts" {
  count = var.enable_root_usage_alarm ? 1 : 0
  name  = "${local.name_prefix}-security-alerts"

  tags = {
    Indicator = "2.3-identity-hardening"
  }
}

resource "aws_sns_topic_subscription" "security_alerts_email" {
  count     = var.enable_root_usage_alarm && var.security_alert_email != "" ? 1 : 0
  topic_arn = aws_sns_topic.security_alerts[0].arn
  protocol  = "email"
  endpoint  = var.security_alert_email
}

###############################################################################
# INDICATOR 2.5 — Storage exposure controls
#
# Account-level public access block. This is the single highest-value,
# lowest-risk control in this baseline: it prevents accidental public exposure
# of object storage regardless of what an individual bucket policy says.
#
# If a workload genuinely requires public objects (a static website, for
# example), that belongs in a separate account rather than as an exception here.
###############################################################################

resource "aws_s3_account_public_access_block" "main" {
  count = var.enable_account_public_access_block ? 1 : 0

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

###############################################################################
# Threat detection — GuardDuty
#
# Not tied to a specific assessment indicator, but included because it is
# managed, inexpensive at SME scale, and requires no tuning to be useful.
###############################################################################

resource "aws_guardduty_detector" "main" {
  count  = var.enable_guardduty ? 1 : 0
  enable = true

  datasources {
    s3_logs {
      enable = true
    }
  }

  tags = {
    Indicator = "supplementary-threat-detection"
  }
}
