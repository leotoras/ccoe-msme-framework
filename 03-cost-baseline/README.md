# Component 3 — Cloud Cost Baseline

Establishes what an organization is actually spending before any optimization work begins, so that
later savings are measured rather than asserted.

**Time required:** 2–3 hours
**Output:** A documented pre-engagement spending baseline
**Prerequisite:** Billing-console read access for every account in scope

---

## Why this comes before optimization

The most common failure in cloud cost work is claiming a saving that cannot be evidenced. A figure
like "we reduced spend 30%" means nothing without a defined starting point, a defined period, and a
defined scope. This component exists to fix all three before anything is changed.

**Set the baseline before you touch anything.** If you optimize first and measure second, you have
no defensible number.

---

## Step 1 — Define the scope

List every account, subscription, or project whose spend is in scope. Anything omitted here will
distort the baseline and every comparison drawn from it.

| Account / subscription ID | Name or purpose | Owner | In scope? |
|---|---|---|---|
| | | | |

**Exclusions must be deliberate and written down.** A sandbox account excluded silently becomes an
unexplained gap when someone reconciles the totals later.

---

## Step 2 — Choose the baseline period

Use **three complete billing months**. One month is too sensitive to a single anomaly; twelve months
buries recent changes in old data.

- If the last three months include an unusual event — a migration, a load test, a one-off data
  transfer — note it rather than excluding it, and record what it cost.
- If the environment is less than three months old, say so and use what exists.

| Baseline period | From | To | Complete months |
|---|---|---|---|
| | | | |

---

## Step 3 — Record the figures

Pull from the provider's cost management console, not from invoices, so the figures reconcile to a
source the client can re-query themselves.

| Month | Total spend | Compute | Storage | Data transfer | Other |
|---|---|---|---|---|---|
| Month 1 | | | | | |
| Month 2 | | | | | |
| Month 3 | | | | | |
| **Mean** | | | | | |

**The mean of three months is your baseline.** State it once, in writing, and use that figure in
every later comparison.

---

## Step 4 — Record what the baseline cannot see

A baseline is only honest if its limits are stated.

- **Committed spend** — reserved instances, savings plans, or committed-use discounts already in
  force will make current spend look lower than list price. Note coverage and expiry.
- **Credits** — promotional or migration credits distort the picture and eventually run out.
- **Shared costs** — anything billed to a parent account or allocated from elsewhere.
- **Seasonality** — if the business has a peak season outside the baseline window, say so.

---

## Step 5 — Attribution coverage

Record what share of spend can currently be attributed to a team, product, or environment. This is
usually the most uncomfortable number in the exercise and the most useful.

| Measure | Value |
|---|---|
| Spend covered by a consistent tagging or account scheme | % |
| Spend that cannot be attributed to any owner | % |

An organization that cannot attribute 40% of its spend does not have a cost problem yet — it has a
visibility problem, and Component 6 addresses it.

---

## What this produces

A single page stating: scope, period, mean monthly spend, breakdown by category, known distortions,
and attribution coverage. Signed or acknowledged by whoever owns the budget.

Every claim made later about cost reduction refers back to this page.

---

*MIT licensed — see the [repository LICENSE](../LICENSE).*
