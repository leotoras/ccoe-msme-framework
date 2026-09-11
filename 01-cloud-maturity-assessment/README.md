# Component 1 — Cloud Governance Maturity Assessment

A scored instrument for establishing where an organization actually stands on cloud governance,
across five domains, using a published rubric so that a score means the same thing between
organizations and between assessments of the same organization over time.

**Time required:** 60–90 minutes
**Output:** A domain-level and overall maturity score (0.00–4.00) and a maturity tier
**Companion file:** [`ccoe-maturity-assessment.xlsx`](ccoe-maturity-assessment.xlsx) — scores automatically

---

## Before you start

**Get the right people in the room.** This assessment fails when one person guesses on behalf of
functions they do not operate. At minimum you want whoever administers cloud accounts, whoever
sees the cloud bill, and whoever would be called at 2am during an outage. In a small
organization that may be two people. It is rarely one.

**Score what is true, not what is intended.** A control that exists in a ticket, a plan, or
someone's head scores 0. The instrument is only useful if it produces an honest baseline, and
an inflated first score makes every subsequent re-measurement look like regression.

**Do not skip indicators.** If an indicator genuinely does not apply — you run no production
workloads at all, say — mark it N/A in the workbook and it is excluded from the denominator
rather than scored zero. Use this sparingly; most "does not apply" answers are really "we have
not done this."

---

## The scoring rubric

Every indicator is scored on the same five-point scale. This rubric is the reason scores are
comparable; apply it literally.

| Score | Level | Definition |
|:---:|---|---|
| **0** | **Absent** | The practice does not exist. No one performs it, and no artifact describes it. Intent to implement scores 0. |
| **1** | **Ad hoc** | The practice happens sometimes, driven by individuals rather than by process. It is not written down, not consistent between people, and would not survive the departure of the person who does it. |
| **2** | **Defined** | The practice is documented and someone owns it. Execution is still largely manual and compliance is not verified — but a new hire could find the document and follow it. |
| **3** | **Managed** | The practice is documented, owned, consistently executed, and **verified**. Deviations are detected. There is evidence the control is actually operating, not merely described. |
| **4** | **Optimized** | As Managed, plus enforced automatically wherever technically possible, and reviewed on a defined cadence with findings driving change. Non-compliance is prevented rather than detected after the fact. |

**The 2→3 boundary is where most organizations over-score themselves.** The difference is
verification. If you cannot produce evidence that the control operated last month, it is a 2.

---

## Domain 1 — Governance and Accountability

*Does anyone actually own cloud decisions, and is that ownership real?*

| # | Indicator | What a 3 looks like |
|:---:|---|---|
| 1.1 | **Named ownership.** A specific person or role is accountable for cloud governance decisions. | The role is documented, the person knows they hold it, and decisions escalate to them in practice. |
| 1.2 | **Account and subscription inventory.** A current, authoritative record of every cloud account, subscription, or project the organization owns. | The inventory is reconciled against the provider's billing console on a defined cadence and discrepancies are investigated. |
| 1.3 | **Provisioning process.** New cloud resources are created through a defined path rather than ad hoc. | Requests are recorded, approved by the accountable owner, and provisioned consistently. |
| 1.4 | **Written architectural standards.** Documented standards exist for how workloads are built and deployed. | Standards are referenced in design decisions and deviations are raised, not silently absorbed. |
| 1.5 | **Governance review cadence.** Cloud posture is reviewed on a defined schedule by the accountable owner. | Reviews occur on schedule, produce findings, and findings are tracked to closure. |

---

## Domain 2 — Security Baseline

*Are the foundational controls in place, and can you prove they are operating?*

| # | Indicator | What a 3 looks like |
|:---:|---|---|
| 2.1 | **Audit logging enabled.** API and management-plane activity is logged across all accounts and regions. | Logging is on everywhere, log integrity is protected, and someone would notice if it stopped. |
| 2.2 | **Configuration recording.** Resource configuration changes are recorded and retained. | Change history is queryable and used during incident review. |
| 2.3 | **Identity hardening.** MFA is enforced for privileged access; root/global-admin credentials are protected and not used routinely. | Enforcement is verified, not assumed; root usage generates an alert. |
| 2.4 | **Least privilege.** Access is granted by role and scoped to need, rather than broad standing administrative rights. | Permissions are reviewed periodically and excess access is removed. |
| 2.5 | **Storage exposure controls.** Object storage and databases are protected against unintentional public exposure. | Public access is blocked at the account level, and exceptions are explicit and documented. |

> **Component 2 of this framework** ([`../02-security-baseline/`](../02-security-baseline/))
> implements indicators 2.1, 2.2, 2.3, and 2.5 directly as deployable infrastructure-as-code.

---

## Domain 3 — Cost Accountability

*Do you know what you are spending, on what, and does anyone answer for it?*

| # | Indicator | What a 3 looks like |
|:---:|---|---|
| 3.1 | **Spend visibility.** Current and historical cloud spend is visible to whoever is accountable for it. | Someone reviews spend on a defined cadence and can explain material changes. |
| 3.2 | **Resource attribution.** Cloud costs can be attributed to a team, product, environment, or customer. | A consistent tagging or account-separation scheme exists and coverage is measured. |
| 3.3 | **Budget and alerting.** Budgets are set and deviations trigger notification to a person who acts. | Alerts route to a named owner and result in investigation, not just an email. |
| 3.4 | **Waste identification.** Idle, orphaned, and oversized resources are identified on a recurring basis. | Findings are produced on a schedule and remediation is tracked. |
| 3.5 | **Commitment and rate optimization.** Reserved capacity, savings plans, or committed-use discounts are evaluated against actual usage. | Coverage is reviewed periodically against changing usage rather than set once. |

---

## Domain 4 — Resilience and Recovery

*If the worst happens, do you recover — and do you know that, or assume it?*

| # | Indicator | What a 3 looks like |
|:---:|---|---|
| 4.1 | **Backup coverage.** Critical data and systems are backed up on a defined schedule. | Coverage is verified against an inventory; gaps are known rather than discovered during an incident. |
| 4.2 | **Restoration testing.** Backups have been restored successfully, deliberately, as a test. | Restores are tested on a defined cadence and the results are recorded. |
| 4.3 | **Documented recovery objectives.** Recovery time and recovery point objectives are defined for critical systems. | Objectives are agreed with the business, not set unilaterally by IT, and are realistic against tested restore times. |
| 4.4 | **Recovery runbook.** A documented procedure exists for recovering critical systems. | The runbook is current, and someone other than its author could follow it. |
| 4.5 | **Resilience architecture.** Critical workloads are designed against single points of failure appropriate to their stated objectives. | Architecture matches the documented objectives rather than exceeding or falling short of them by accident. |

---

## Domain 5 — Workforce Capability

*Does the capability live in the organization, or in one person's head?*

| # | Indicator | What a 3 looks like |
|:---:|---|---|
| 5.1 | **Defined responsibilities.** Cloud operational responsibilities are documented and assigned. | Assignments are current and cover the work that actually exists. |
| 5.2 | **Onboarding material.** New staff receive documented material on cloud standards and practices. | Material is current and its completion is recorded. |
| 5.3 | **Bus-factor mitigation.** No single individual is the sole holder of knowledge required to operate critical cloud systems. | At least two people can perform each critical operational task, demonstrably. |
| 5.4 | **Security awareness.** Staff with cloud access receive recurring security guidance relevant to their access. | Delivery is recurring and tracked, not one-time at hire. |
| 5.5 | **Skills development.** Cloud capability development is planned rather than incidental. | A plan exists, is funded, and is reviewed. |

---

## Calculating your score

**Domain score** = mean of that domain's five indicator scores (excluding any marked N/A).
**Overall maturity score** = mean of the five domain scores.

Domains are weighted equally. This is deliberate: an organization with excellent security and no
cost accountability is not "mostly fine," and averaging indicators rather than domains would let
a strong domain mask an absent one.

### Maturity tiers

| Overall score | Tier | What it means |
|:---:|---|---|
| **0.00 – 0.99** | **Ad Hoc** | Cloud is operated without governance. Outcomes depend on individuals. This is the most common starting point for an SME and is not a judgment — it is a baseline. |
| **1.00 – 1.99** | **Emerging** | Practices exist but are inconsistent and undocumented. Vulnerable to staff turnover. |
| **2.00 – 2.99** | **Defined** | Practices are documented and owned. The main gap is verification — you can describe your controls but not prove they operated. |
| **3.00 – 3.49** | **Managed** | Controls operate and are verified. The organization has genuine governance. |
| **3.50 – 4.00** | **Optimized** | Controls are enforced automatically and reviewed on cadence. Non-compliance is prevented rather than detected. |

**A first-time score between 0.5 and 1.5 is normal** for an SME that has grown into cloud rather
than planning for it. It is not a failing grade. It is the number you improve against.

---

## What to do with the result

1. **Record the date and the score.** Both matter. The score is only meaningful as a series.
2. **Read your lowest domain first.** Remediation buys the most where the score is lowest, not
   where the work is most interesting.
3. **Target the 0s and 1s before polishing the 2s.** Moving an indicator from 0 to 2 removes a
   category of risk. Moving one from 3 to 4 optimizes a control that already works.
4. **Re-assess after 90 days.** Sooner produces noise; much later loses the connection between
   the remediation and the result.

---

## Mapping to published guidance

These indicators are not novel. They are the SME-scoped expression of controls that appear
across widely adopted frameworks. Where an indicator corresponds to published guidance, the
correspondence is noted below so that an organization already working against one of these
frameworks can reconcile the two rather than duplicating effort.

| Domain | Corresponds broadly to |
|---|---|
| 1 — Governance and Accountability | NIST CSF *Govern*; CIS Controls 1–2 (asset inventory) |
| 2 — Security Baseline | NIST CSF *Protect* / *Detect*; CIS Controls 3, 5, 6, 8 |
| 3 — Cost Accountability | FinOps Foundation capability domains (Inform, Optimize) |
| 4 — Resilience and Recovery | NIST CSF *Recover*; CIS Control 11 |
| 5 — Workforce Capability | NIST CSF *Govern* (roles, responsibilities); CIS Control 14 |

These are directional mappings intended to aid reconciliation. They are not certifications, and
scoring well here does not constitute compliance with any framework.

---

## License

MIT — see the [repository LICENSE](../LICENSE). Use it, adapt it, run it inside your own
organization or your clients'. Attribution appreciated, not required.
