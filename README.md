# MSME Cloud Governance Framework

An open, free framework that helps small and mid-sized enterprises establish and operate a
Cloud Center of Excellence (CCoE) — the standing governance function that holds the standards
by which cloud resources are provisioned, secured, governed, and paid for.

Its purpose is to strengthen the **cybersecurity and operational resilience** of smaller firms. Cost governance is
part of it for a practical reason: savings are what persuade a small firm to adopt governance, and governance is
what makes it harder to breach and faster to recover.

Most large enterprises operate a CCoE; fewer than half of small and mid-sized enterprises do,
and the gap shows up as inconsistent security configuration across accounts, duplicated
engineering effort, unclear architectural ownership, and cloud spending that grows without
corresponding accountability. That gap is not a knowledge problem — the practices are well
documented by every major cloud provider. It is a **packaging** problem: enterprise governance
material assumes a dedicated governance team that an SME does not have.

This framework exists to close that gap. Everything here is free, openly licensed, and designed
to be adopted by an organization without a dedicated cloud governance function.

---

## Who this is for

- SMEs running workloads on AWS, Azure, or Google Cloud without a formal governance function
- IT leads and MSPs who need a defensible starting baseline rather than a blank page
- Organizations that supply larger enterprises and are being asked, increasingly, to
  demonstrate their own security posture

You do not need to be a large organization to use this. That is the point.

---

## Why this matters beyond any single company

Small and mid-sized enterprises are not only consumers of cloud infrastructure — they are
suppliers, vendors, and service providers to larger organizations. A governance failure at a
small supplier does not stay contained to that supplier.

Verizon's *2025 Data Breach Investigations Report* found that third-party involvement in
confirmed breaches **doubled year over year, to 30%**. Every SME that hardens its own cloud
governance removes itself as an access path into the organizations it serves.

---

## The framework

Nine core components, executed in sequence, plus an optional extension for organizations running
AI workloads. Each is published as a working artifact — something you run, deploy, or adopt —
rather than a description of something you should build.

| # | Component | Output it produces |
|---|---|---|
| 1 | [Cloud maturity assessment](01-cloud-maturity-assessment/) | Baseline governance maturity score |
| 2 | [Security baseline implementation](02-security-baseline/) | Security-control adoption rate |
| 3 | [Cost baseline](03-cost-baseline/) | Documented pre-engagement spending baseline |
| 4 | [Architecture review](04-architecture-review/) | Prioritized architectural findings register |
| 5 | [Governance policy package](05-governance-policy-package/) | Adopted written policies |
| 6 | [FinOps controls](06-finops-controls/) | Cloud cost reduction against baseline |
| 7 | [Disaster recovery](07-disaster-recovery/) | Tested recovery capability |
| 8 | [Employee training](08-employee-training/) | Staff training completion |
| 9 | [Continuous monitoring](09-continuous-monitoring/) | Sustained governance maturity score |
| 10 | [AI workload governance](10-ai-workload-governance/) | *Optional* — governance for cloud-hosted AI |

**All ten components are now published.** Component 10 applies only where AI workloads are in
use; organizations without them use Components 1 through 9 and mark the AI domain not applicable.

---

## Security and resilience alignment — NIST Cybersecurity Framework 2.0

The nine core components map to the six functions of the
[NIST Cybersecurity Framework (CSF) 2.0](https://www.nist.gov/cyberframework):

| CSF 2.0 function | Framework components | Coverage |
|---|---|---|
| Govern (GV.PO, GV.RM) | 1 Maturity assessment · 5 Governance policy package · 10 AI workload governance (optional) | Addressed |
| Identify (ID.AM, ID.RA) | 1 Maturity assessment · 3 Cost baseline (resource inventory) · 4 Architecture review | Addressed |
| Protect (PR.AA, PR.DS, PR.PS, PR.AT, PR.IR) | 2 Security baseline · 5 Access-control policies · 8 Employee training · 4 Resilience standards | Addressed |
| Detect (DE.CM) | 2 Audit logging and configuration recording · 9 Continuous monitoring | Addressed |
| Respond (RS.MA, RS.CO) | 5 Compromise reporting (access-control policy) · SME-scoped incident response plan listed as planned | Partial — incident response plan not yet published |
| Recover (RC.RP) | 7 Disaster recovery | Addressed |

FinOps controls (component 6) lie outside the CSF's scope by design. Like the component-level
mappings in each folder, these are directional mappings intended to aid reconciliation. They are
not certifications, and adopting the framework does not constitute compliance with any standard.

## How outcomes are measured

Every implementation is assessed against the same six indicators:

1. **Security-control adoption rate** — share of the security baseline implemented and operating
2. **Disaster-recovery readiness** — recovery procedures documented and tested
3. **Governance maturity score** — movement from the component-1 baseline, re-measured under component 9
4. **Employee training completion** — staff completing the knowledge-transfer curriculum
5. **Cloud migration success rate** — workloads migrated within the framework's architectural and security standards
6. **Cloud cost reduction achieved** — realized savings against the component-3 baseline

Aggregate, anonymized results for these indicators will be published here annually.

---

## Start here

The components are designed to be used in order. The first three establish where you stand:

### 1. Measure where you are
**[`01-cloud-maturity-assessment/`](01-cloud-maturity-assessment/)** — a 25-indicator scored
instrument across five governance domains, with a published rubric and a workbook that calculates
domain and overall maturity automatically. About 60–90 minutes.

### 2. Close the most common gaps
**[`02-security-baseline/`](02-security-baseline/)** — a Terraform reference configuration
implementing foundational AWS security controls, with honest documentation of what it does *not*
cover.

### 3. Know what you are spending
**[`03-cost-baseline/`](03-cost-baseline/)** — establishes a defensible spending baseline before
any optimization, so later savings are measured rather than asserted.

**Then:** architecture review (4), written policy (5), cost accountability (6), resilience (7),
training (8), and a review cadence that keeps it from decaying (9).

**The loop:** assess → remediate → govern → train → re-assess. Component 1 produces the number the
others are designed to move, and Component 9 re-measures it on a schedule.

---

## How to use this

1. Clone or download the repository.
2. Run the maturity assessment. Record the score — you will want the baseline later.
3. Read the lowest-scoring domain first. That is where remediation buys the most.
4. Deploy the security baseline in a non-production account, review the plan, then promote it.
5. Establish the cost baseline before changing anything about spend.
6. Adapt the access control policy, get it approved, and issue it.
7. Set the review cadence in Component 9 with real dates.
8. Re-run the assessment after 90 days.

Nothing here requires engaging anyone. If your organization has the internal capacity to adopt
these materials directly, that is the intended outcome.

---

## Provenance

This framework is adapted from Cloud Center of Excellence governance disciplines the author
designed and operated at three unrelated employers across three industries — a fintech payments
processor, a specialty-chemicals manufacturer spanning information and operational technology,
and a multinational technology conglomerate. The enterprise implementations produced documented
results including a multi-application, two-continent data center consolidation, a governance-driven
cost reduction achieved within two months, and a processing-time improvement exceeding ninety
percent.

What is published here is not those implementations. It is the same underlying discipline,
deliberately re-scoped for organizations without dedicated governance staff.

---

## Relationship to federal guidance

Executive Order 14028 established software supply-chain security, zero-trust architecture, and
the NIST Secure Software Development Framework as federal cybersecurity priorities. NIST Special
Publication 1300, the *Cybersecurity Framework 2.0 Small Business Quick-Start Guide*, addresses
small businesses with "modest or no cybersecurity plans in place." For AI workloads, Executive
Order 14179 and *America's AI Action Plan* (July 2025) set current federal AI policy.

Those directives govern federal agencies and their suppliers; they do not by their terms apply to
private SMEs, and nothing here claims to implement them on anyone's behalf. Federal guidance
largely defines *what* to achieve. This framework supplies deployable artifacts for organizations
without the staff to work out *how* — and where a control maps to published guidance, the mapping
is noted in that component's documentation. A framework-level mapping to the six CSF 2.0 functions
appears above.

---

## Contributing

Issues and pull requests are welcome, particularly:

- Azure and Google Cloud implementations of the security baseline
- Sector-specific adaptations of the policy templates
- Corrections to the assessment rubric where indicator wording is ambiguous

Please open an issue before submitting a large change, so we can agree on scope first.

---

## License

Released under the MIT License. See [`LICENSE`](LICENSE).

MIT was chosen deliberately over a copyleft license: the intent is that organizations adopt,
modify, and internalize this material with as little friction as possible, including inside
commercial contexts. Attribution is appreciated but adoption matters more.

---

## Author

**Leonardo Toras Junior** — Senior Cloud Solutions Architect; IEEE Senior Member; 17+ years in
IT infrastructure, including cloud architecture and governance, across financial services, manufacturing, and enterprise
technology.
