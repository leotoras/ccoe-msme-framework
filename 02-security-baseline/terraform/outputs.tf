###############################################################################
# Outputs — record these. Several are needed when you re-run the maturity
# assessment, and the evidence_summary is designed to be pasted directly into
# the assessment's Notes column.
###############################################################################

output "audit_log_bucket" {
  description = "S3 bucket receiving CloudTrail and AWS Config data."
  value       = aws_s3_bucket.audit_logs.id
}

output "cloudtrail_arn" {
  description = "ARN of the multi-region CloudTrail."
  value       = aws_cloudtrail.main.arn
}

output "config_recorder_enabled" {
  description = "Whether AWS Config configuration recording was deployed."
  value       = var.enable_config
}

output "guardduty_detector_id" {
  description = "GuardDuty detector ID, or null if not enabled."
  value       = var.enable_guardduty ? aws_guardduty_detector.main[0].id : null
}

output "security_alert_topic_arn" {
  description = "SNS topic for security alerts. Subscribe additional endpoints here."
  value       = var.enable_root_usage_alarm ? aws_sns_topic.security_alerts[0].arn : null
}

output "account_public_access_blocked" {
  description = "Whether account-level S3 public access block was applied."
  value       = var.enable_account_public_access_block
}

output "evidence_summary" {
  description = "Deployment evidence for maturity assessment indicators 2.1, 2.2, 2.3, 2.5."
  value = {
    "2.1_audit_logging"         = "CloudTrail ${aws_cloudtrail.main.name}: multi-region, log file validation enabled, delivering to ${aws_s3_bucket.audit_logs.id}"
    "2.2_configuration_recording" = var.enable_config ? "AWS Config recorder enabled, all supported resource types including global" : "NOT DEPLOYED — indicator 2.2 remains unaddressed"
    "2.3_identity_hardening"    = var.manage_password_policy ? "IAM password policy managed: minimum ${var.password_minimum_length} characters, complexity required. MFA enforcement must be verified manually — see README." : "NOT MANAGED — password policy handled externally"
    "2.5_storage_exposure"      = var.enable_account_public_access_block ? "Account-level S3 public access block applied to all four settings" : "NOT APPLIED — indicator 2.5 remains unaddressed"
  }
}
