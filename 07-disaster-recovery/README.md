# Component 7 — Disaster Recovery

Establishes recovery objectives that the business has agreed to, procedures someone other than their
author can follow, and evidence that a restore has actually worked.

**Output:** Recovery objectives per system, a runbook, and a tested restore record

---

## The test this component applies

**An untested backup is a hypothesis.** The single question this component answers is whether the
organization has restored something, deliberately, and recorded the result. Everything else is
preparation for being able to answer it.

---

## Step 1 — Agree recovery objectives with the business

Objectives set by IT alone are guesses about business tolerance. Set them with whoever absorbs the
consequences of downtime.

| System | RTO (how long until restored) | RPO (how much data may be lost) | Agreed with | Date |
|---|---|---|---|---|
| | | | | |

**Two rules that keep this honest:**

- An RTO shorter than your tested restore time is not an objective, it is a wish. Record the tested
  figure alongside it.
- Not every system needs aggressive objectives. Classifying a reporting database as tier 3 is a
  legitimate decision, and writing it down protects everyone later.

---

## Step 2 — Verify backup coverage against an inventory

Coverage is measured against what exists, not against what is backed up.

| System / dataset | Backed up? | Frequency | Retention | Stored where | Encrypted |
|---|---|---|---|---|---|
| | | | | | |

**Look specifically for:** configuration and infrastructure state, not only data; secrets and key
material; and anything created after the backup policy was written.

**Backups must survive the failure they protect against.** A backup in the same account and region
as the source does not survive account compromise or regional loss.

---

## Step 3 — Recovery runbook

| Section | Contents |
|---|---|
| Trigger | What conditions invoke this procedure |
| Authority | Who decides to invoke it, and who may be called |
| Sequence | Ordered restoration steps with dependencies stated |
| Verification | How to confirm the restore actually worked |
| Communication | Who is informed, at what points |
| Rollback | What to do if the restore fails |

**Write for a competent person who was not involved in building the system.** If the runbook
assumes knowledge only its author has, it will fail at the moment its author is unreachable.

---

## Step 4 — Test the restore and record it

| Date | System tested | Type | Target RTO | Actual | Result | Issues found |
|---|---|---|---|---|---|---|
| | | Full / partial / tabletop | | | Pass / fail | |

**Test at least annually per tier-1 system.** A failed test that surfaces a real problem is a
successful exercise; record it as such rather than repeating until it passes.

**Findings from tests feed back into the runbook.** A test that changes nothing was either perfect
or not examined closely enough.

---

## Common findings

| Finding | Why it recurs |
|---|---|
| Backups exist; nobody has restored one | Backup is automated, restore is not |
| RTO agreed with nobody | Set by IT in isolation |
| Runbook references a departed employee | Never reviewed after staffing changes |
| Secrets not backed up | Treated as configuration rather than data |
| Backups in the same account as the source | Convenience at setup time |

---

*MIT licensed — see the [repository LICENSE](../LICENSE).*
