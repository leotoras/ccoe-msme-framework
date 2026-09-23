# Component 6 — FinOps Controls

Converts cost visibility into cost accountability: who owns which spend, who is notified when it
moves, and what happens next.

**Prerequisite:** Component 3 (Cost Baseline) complete
**Output:** Attribution scheme, budgets with named owners, and a recurring review

---

## The distinction that matters

**Visibility is knowing what you spent. Accountability is someone answering for it.** Most SMEs
reach the first and stop. A dashboard nobody owns changes nothing.

Every control below exists to attach a name to a number.

---

## Control 1 — Attribution scheme

Decide how spend maps to responsibility, and apply it consistently. Two workable patterns:

| Pattern | Use when | Trade-off |
|---|---|---|
| **Account separation** | Teams or environments are clearly distinct | Cleanest attribution; more accounts to govern |
| **Tagging** | Shared accounts are unavoidable | Flexible; only as good as tag coverage |

**Minimum tag set**, if tagging:

| Tag | Purpose | Example |
|---|---|---|
| `owner` | The person or team accountable | `platform-team` |
| `environment` | Separates production from the rest | `prod` / `staging` / `dev` |
| `service` | The product or system | `order-api` |
| `cost-center` | Maps to the finance system | `CC-4402` |

**Measure tag coverage monthly and publish the number.** Coverage that is never measured decays
to nothing within two quarters.

---

## Control 2 — Budgets with named owners

A budget without a name attached is a notification, not a control.

| Scope | Monthly budget | Owner (named person) | Alert thresholds |
|---|---|---|---|
| | | | 50% / 80% / 100% / forecast |

- Alerts route to **a person**, not a shared inbox.
- Set a **forecast** alert as well as actual-spend alerts — a forecast breach is actionable while an
  actual breach is already sunk.
- Record what the owner is expected to do when alerted. "Investigate" is sufficient; nothing is not.

---

## Control 3 — Recurring waste review

Run monthly. The categories below account for the large majority of recoverable SME spend.

| Category | What to look for | Typical finding |
|---|---|---|
| Idle compute | Instances with sustained low utilization | Dev environments running nights and weekends |
| Orphaned storage | Volumes and snapshots with no attachment | Snapshots from migrations completed years ago |
| Oversized resources | Provisioned far above observed use | Initial sizing never revisited |
| Unattached addresses | Static IPs billed while unused | |
| Old generation instances | Superseded families at higher cost | Same performance available cheaper |
| Untiered object storage | Infrequently accessed data on standard tiers | |
| Redundant environments | Environments nobody remembers creating | |

**Record findings and track them to closure.** A monthly review that produces findings nobody
actions produces a longer list each month and no savings.

---

## Control 4 — Commitment coverage

Reserved capacity, savings plans, and committed-use discounts reduce rates substantially — and lock
you in.

| Question | Record |
|---|---|
| Current commitment coverage of steady-state usage | % |
| Expiry dates of existing commitments | |
| Workloads stable enough to commit | |
| Workloads deliberately left on demand | |

**Review quarterly, not once.** Usage changes; a commitment sized for last year's workload is a
cost, not a saving.

---

## Control 5 — Cost in the change path

The cheapest optimization is the resource never provisioned oversized.

- New workloads state an expected monthly cost before provisioning.
- Significant increases are visible to the budget owner before they land, not after.
- Infrastructure-as-code review includes sizing as a review point.

---

## What "good" looks like

| Indicator | Target |
|---|---|
| Spend attributable to a named owner | > 90% |
| Budgets with a named owner | 100% of accounts in scope |
| Waste review completed | Monthly, findings tracked |
| Commitment coverage reviewed | Quarterly |
| Cost reduction against the Component 3 baseline | Measured and stated |

---

*MIT licensed — see the [repository LICENSE](../LICENSE).*
