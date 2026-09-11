# Component 2 — Cloud Security Baseline

A Terraform reference configuration implementing foundational AWS security controls for small and
mid-sized enterprises. Deliberately scoped to controls that are **high-value, low-controversy, and
operable by an organization without a security team**.

**Implements maturity assessment indicators 2.1, 2.2, 2.3, and 2.5.**

---

## What this deploys

| Control | Resource | Assessment indicator |
|---|---|---|
| Multi-region audit logging with log file validation | CloudTrail + hardened S3 bucket | **2.1** |
| Resource configuration recording | AWS Config recorder and delivery channel | **2.2** |
| IAM password policy | Account password policy | **2.3** (partial) |
| Security alerting channel | SNS topic with optional email subscription | **2.3** (supporting) |
| Account-level public access block | S3 account public access block | **2.5** |
| Managed threat detection | GuardDuty detector | Supplementary |

Everything is toggleable. If a control is already managed elsewhere — password policy handled by
your identity provider, for instance — set its variable to `false` rather than fighting your
existing setup.

---

## What this deliberately does **not** do

Being explicit about scope matters more than appearing comprehensive.

- **It does not enforce MFA.** AWS cannot mandate MFA for existing users through IAM configuration
  alone; it requires either a permission boundary denying actions without MFA, or enforcement at
  the identity provider. Both are organization-specific decisions with real lockout risk, so this
  baseline does not make them for you. **See "Manual steps" below — indicator 2.3 is not complete
  without them.**
- **It does not touch networking.** VPC design, security groups, and network segmentation depend
  entirely on your workloads. A generic network baseline would be either useless or dangerous.
- **It does not manage users, roles, or permissions.** That is governed by
  [Component 5's access control policy](../05-governance-policy-package/cloud-access-control-policy.md),
  and the implementation is organization-specific.
- **It does not make you compliant with anything.** These are sound foundational controls. They
  are not a SOC 2, PCI-DSS, HIPAA, or CMMC control set, and deploying them is not an audit finding.

---

## Before you deploy

**Read `variables.tf`.** Every default is a starting point, not a determination about your
obligations. In particular:

- `log_retention_days` defaults to 365. If you are subject to sector-specific retention
  requirements, set it accordingly **before** first apply — shortening retention later does not
  recover logs you already expired.
- `enable_account_public_access_block` defaults to `true`. If this account intentionally serves
  public objects (a static site, a public data set), this **will break it**. The better pattern is
  to move public content to a dedicated account rather than disabling the control here.
- `enable_config` incurs per-configuration-item charges. At SME scale this is typically modest, but
  it is not free — check it against your budget rather than discovering it on the bill.

**Deploy to a non-production account first.** Review the plan output in full. This configuration
creates an S3 bucket with `force_destroy = false`, which is intentional — audit logs should not be
trivially destroyable, including by you.

---

## Deploying

```bash
cd terraform

terraform init

# Review carefully. Nothing here is destructive to existing resources,
# but the account-level public access block affects the whole account.
terraform plan \
  -var="name_prefix=yourorg-baseline" \
  -var="security_alert_email=security@yourorg.example"

terraform apply \
  -var="name_prefix=yourorg-baseline" \
  -var="security_alert_email=security@yourorg.example"
```

If you supplied `security_alert_email`, **confirm the SNS subscription** from the email AWS sends.
An unconfirmed subscription delivers nothing, and this is the single most commonly missed step.

---

## Manual steps this configuration cannot perform

Indicator 2.3 is **not** complete after `terraform apply`. Three things require human action:

1. **Enable MFA on the root account.** Console → IAM → Security credentials. If root MFA is not
   enabled, nothing else in this baseline matters much.
2. **Enforce MFA for all human users.** Either attach a permission boundary denying actions when
   `aws:MultiFactorAuthPresent` is false, or enforce it at your identity provider if you federate.
   Test with a non-privileged account before applying broadly — misconfiguring this locks people
   out.
3. **Stop using root for routine work.** Create an administrative IAM identity or federate, then
   put the root credentials in your password manager and leave them there.

Deploying this baseline without doing these three things produces a good audit trail of an
inadequately protected account.

---

## Verifying it worked

```bash
# Audit logging is on, multi-region, and validating
aws cloudtrail describe-trails --query 'trailList[].{Name:Name,MultiRegion:IsMultiRegionTrail,Validation:LogFileValidationEnabled}'
aws cloudtrail get-trail-status --name <trail-name> --query 'IsLogging'

# Configuration recording is running
aws configservice describe-configuration-recorder-status --query 'ConfigurationRecordersStatus[].{Name:name,Recording:recording}'

# Account-level public access block is applied
aws s3control get-public-access-block --account-id <your-account-id>

# GuardDuty is enabled
aws guardduty list-detectors
```

Terraform also emits an `evidence_summary` output written specifically to be pasted into the Notes
column of the maturity assessment workbook:

```bash
terraform output evidence_summary
```

---

## Effect on your maturity score

Deploying this baseline and completing the manual steps moves these indicators in
[Component 1](../01-cloud-maturity-assessment/):

| Indicator | Before (typical) | After |
|---|:---:|:---:|
| 2.1 Audit logging enabled | 0–1 | **3** |
| 2.2 Configuration recording | 0 | **3** |
| 2.3 Identity hardening | 1 | **3** *(only with the manual steps)* |
| 2.5 Storage exposure controls | 1–2 | **4** |

For an organization starting near zero on Domain 2, that is roughly a **+2.5 domain improvement**,
or about **+0.5 on the overall maturity score** — from one afternoon of work.

**Why 2.1 reaches 3 and not 4:** a score of 4 requires review on a defined cadence with findings
driving change. Terraform deploys the control; it cannot make someone read the logs. Reaching 4 on
this indicator is a Component 9 (continuous monitoring) concern.

---

## Cost

Approximate monthly cost at SME scale in `us-east-1`, for a small account:

| Service | Typical monthly cost |
|---|---|
| CloudTrail (first trail, management events) | **Free** |
| S3 storage for logs | A few dollars, scaling with activity |
| AWS Config | Per configuration item recorded — usually the largest line here |
| GuardDuty | Low tens of dollars, scaling with event volume |
| SNS | Effectively free at this volume |

AWS Config is the variable to watch. If cost is a concern, set `enable_config = false` for an
initial deployment and add it once you have measured the rest — but note that indicator 2.2 stays
unaddressed until you do.

*These are directional estimates, not a quote. Check current AWS pricing for your region and usage.*

---

## Contributing

Azure and Google Cloud equivalents of this baseline are wanted. If you build one, please match the
structure here: the same indicator mapping, the same explicitness about what is *not* covered, and
the same `evidence_summary` output pattern so results stay comparable across platforms.

---

*MIT licensed — see the [repository LICENSE](../LICENSE).*
