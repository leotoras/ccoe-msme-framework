###############################################################################
# Variables — MSME Cloud Governance Framework, Component 2
#
# Defaults are chosen to be safe for a first deployment. Review each before
# applying; the defaults are a starting point, not a determination about your
# regulatory obligations.
###############################################################################

variable "aws_region" {
  description = "AWS region for regional resources. CloudTrail is multi-region regardless of this setting."
  type        = string
  default     = "us-east-1"
}

variable "name_prefix" {
  description = "Prefix for resource names. Keep it short; the account ID is appended automatically."
  type        = string
  default     = "ccoe-baseline"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,20}$", var.name_prefix))
    error_message = "name_prefix must be 3-20 characters, lowercase letters, numbers, and hyphens only."
  }
}

variable "log_retention_days" {
  description = "Retention period for audit logs, in days. Increase to meet sector-specific obligations before deploying."
  type        = number
  default     = 365

  validation {
    condition     = var.log_retention_days >= 90
    error_message = "log_retention_days must be at least 90. Shorter retention undermines the purpose of audit logging."
  }
}

variable "enable_config" {
  description = "Enable AWS Config configuration recording (assessment indicator 2.2). Incurs per-item recording charges."
  type        = bool
  default     = true
}

variable "enable_guardduty" {
  description = "Enable GuardDuty threat detection. Inexpensive at SME scale and requires no tuning."
  type        = bool
  default     = true
}

variable "enable_account_public_access_block" {
  description = "Block public access to S3 at the ACCOUNT level (indicator 2.5). Set false only if this account intentionally hosts public objects."
  type        = bool
  default     = true
}

variable "manage_password_policy" {
  description = "Manage the IAM account password policy. Set false if password policy is managed elsewhere, e.g. by an identity provider."
  type        = bool
  default     = true
}

variable "password_minimum_length" {
  description = "Minimum IAM password length."
  type        = number
  default     = 14

  validation {
    condition     = var.password_minimum_length >= 12
    error_message = "password_minimum_length must be at least 12."
  }
}

variable "password_max_age_days" {
  description = "Maximum IAM password age in days. Note that forced rotation is no longer recommended by NIST SP 800-63B where MFA is enforced; set to 0 to disable."
  type        = number
  default     = 90
}

variable "enable_root_usage_alarm" {
  description = "Create the SNS topic used for security alerting, including root-usage notification."
  type        = bool
  default     = true
}

variable "security_alert_email" {
  description = "Email address to receive security alerts. Leave empty to create the topic without a subscription and wire it up later."
  type        = string
  default     = ""

  validation {
    condition     = var.security_alert_email == "" || can(regex("^[^@]+@[^@]+\\.[^@]+$", var.security_alert_email))
    error_message = "security_alert_email must be a valid email address or an empty string."
  }
}
