# Component 4 — Architecture Review

A structured review of cloud architecture against resilience, scalability, and operational criteria,
producing a prioritized findings register rather than a narrative report.

**Time required:** 1–2 days for a typical SME estate
**Output:** A findings register with severity, effort, and owner
**Scope:** Production workloads first; non-production only if time allows

---

## How to run it

Work through the checklist per workload, not per account. A finding recorded against "the AWS
account" is rarely actionable; a finding recorded against "the customer-facing order API" is.

Score each item **Met / Partial / Not met / Not applicable**, and record evidence for anything
scored Met. An item scored Met without evidence is scored Partial.

---

## A. Availability and failure domains

| # | Check | Why it matters |
|:---:|---|---|
| A1 | Production workloads span more than one availability zone | Single-AZ deployment fails entirely on one zone outage |
| A2 | Stateful components have a defined failover path | Databases and queues are where single points of failure usually hide |
| A3 | Load balancing health checks reflect application health, not just port reachability | A process can answer on :443 and still be broken |
| A4 | No workload depends on a single NAT gateway, bastion, or shared appliance | Shared chokepoints turn one failure into many |
| A5 | Failure of any one component has been tested, not assumed | Untested failover is a plan, not a capability |

## B. Scalability and capacity

| # | Check | Why it matters |
|:---:|---|---|
| B1 | Scaling is automatic where load varies, and its limits are known | Autoscaling with a max that was never revisited is a ceiling nobody remembers |
| B2 | Resource sizing is based on observed utilization, not initial guesses | Most SME over-spend originates here |
| B3 | Service quotas and account limits are documented for each critical service | Quota exhaustion presents as an outage with no error in the application |
| B4 | Storage growth is projected, not just monitored | Running out of storage is predictable and therefore inexcusable |

## C. Network and access paths

| # | Check | Why it matters |
|:---:|---|---|
| C1 | Network segmentation separates production from non-production | Shared networks make a development mistake a production incident |
| C2 | Ingress paths are enumerated and each one is intended | Unknown ingress is the most common finding in this section |
| C3 | Inter-service traffic is authenticated, not merely reachable | Network position is not an identity |
| C4 | Administrative access does not traverse the public internet unprotected | |

## D. Data

| # | Check | Why it matters |
|:---:|---|---|
| D1 | Data at rest is encrypted, and key management is documented | Encryption with an unmanaged key is a partial control |
| D2 | Data in transit uses current TLS throughout, including internal hops | |
| D3 | Data retention is defined per dataset, not per system | |
| D4 | Production data is not present in non-production environments | The most common source of unintended exposure |

## E. Operability

| # | Check | Why it matters |
|:---:|---|---|
| E1 | Every production workload emits logs to a central destination | |
| E2 | Alerting distinguishes actionable from informational | Alert fatigue is a governance failure, not an operations one |
| E3 | Deployment is repeatable and does not depend on one person's machine | |
| E4 | Infrastructure is defined as code, or the gap is documented | |

---

## Findings register

Record every non-Met item here. This register, not the checklist, is the deliverable.

| ID | Workload | Check | Severity | Effort | Owner | Target date |
|---|---|---|---|---|---|---|
| | | | High / Med / Low | S / M / L | | |

**Severity is about consequence, not effort.** A one-line fix that prevents data loss is High
severity and Small effort, and it should be obvious from the register that it gets done first.

---

## Deliberate limits

This review does not cover application code, business logic, or vendor contract terms. It assesses
how infrastructure is arranged and operated. Saying so explicitly keeps the review credible.

---

*MIT licensed — see the [repository LICENSE](../LICENSE).*
