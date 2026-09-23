# Component 9 — Continuous Monitoring

Keeps governance from decaying after implementation, by fixing a review cadence and re-measuring the
maturity score on a schedule.

**Output:** A recurring governance review with recorded findings
**Prerequisite:** Component 1 baseline score recorded

---

## The problem this addresses

**Governance decays quietly.** Controls drift, ownership changes hands without handover, exceptions
outlive their justification, and tag coverage falls. None of this announces itself. An organization
that reached "Managed" and stopped measuring will be somewhere below it a year later without anyone
having made a decision.

---

## The cadence

| Frequency | Activity | Owner | Output |
|---|---|---|---|
| **Monthly** | Cost and waste review (Component 6) | Budget owner | Findings tracked to closure |
| **Quarterly** | Access review (Component 5 policy) | Policy owner | Access confirmed or revoked |
| **Quarterly** | Security control verification | IT lead | Controls confirmed operating |
| **Semi-annual** | Maturity re-assessment (Component 1) | Governance owner | Updated score, trend |
| **Annual** | Restore test (Component 7) | IT lead | Tested RTO recorded |
| **Annual** | Policy review | Policy owner | Reissued or confirmed |

**Set dates, not intervals.** "Quarterly" becomes annual within two years; "the second Tuesday of
January, April, July and October" does not.

---

## Quarterly control verification

The point is evidence that a control operated, not confirmation that it exists.

| Control | Evidence to produce | Verified | Date |
|---|---|---|---|
| Audit logging | Trail status active, log delivery within last 24h | | |
| Configuration recording | Recorder status active | | |
| Storage exposure | Account-level public access block still applied | | |
| Identity — MFA | No console user without MFA | | |
| Identity — root | No root usage since last review, or usage justified | | |
| Threat detection | Detector enabled; findings triaged | | |

**A control that cannot produce evidence scores 2 on the maturity assessment, not 3.** That is the
same boundary the rubric applies, and applying it consistently is what keeps the score meaningful.

---

## Maturity trend

Re-score every six months using the same instrument and rubric. Record the series, not just the
latest number.

| Date | Governance | Security | Cost | Resilience | Workforce | Overall |
|---|---|---|---|---|---|---|
| Baseline | | | | | | |
| +6 months | | | | | | |
| +12 months | | | | | | |

**Interpreting movement:** a domain falling by more than half a point between assessments usually
indicates an ownership change rather than a technical regression. Check who left before checking
what broke.

---

## Exception register

| ID | Exception | Justification | Approved by | Expiry | Compensating control |
|---|---|---|---|---|---|
| | | | | | |

**Review every exception at every quarterly review.** An exception past its expiry is a finding, not
a standing arrangement.

---

*MIT licensed — see the [repository LICENSE](../LICENSE).*
