# Component 10 — AI Workload Governance

Extends the framework to cloud-hosted AI workloads: who may invoke models, what data reaches them,
and what the compute costs.

**Status:** Released
**Applies when:** An organization runs, calls, or fine-tunes AI models on cloud infrastructure
**Relationship to the rest of the framework:** This component adds AI-specific controls. It does not
replace Components 1 through 9, which apply to AI workloads as they do to any other.

---

## Why this is a governance problem, not a modelling one

Small and mid-sized organizations are adopting AI services faster than they are governing them, and
the failure modes are the same ones the rest of this framework addresses, arriving through a new
door:

- **Access without boundaries** — model endpoints invoked by anything holding a generic key
- **Data leaving its intended scope** — production or customer data sent to a model as context or
  training input, often without anyone deciding that it should be
- **Cost with no ceiling** — accelerated compute and per-token billing can move faster than any
  other line on a cloud bill
- **No record of what happened** — inference calls that leave no audit trail

None of these require expertise in machine learning to govern. They require the same disciplines
applied everywhere else in this framework.

---

## Control A — Model access

| # | Control | Evidence of operation |
|:---:|---|---|
| A1 | Model invocation permissions are granted by role, not by shared key | Role definitions; no long-lived keys in use |
| A2 | Model endpoints are enumerated, with an owner for each | Inventory reconciled against provider console |
| A3 | Non-production workloads cannot invoke production model endpoints | Separate credentials or accounts |
| A4 | Inference requests are logged with caller identity | Sample log entries |

## Control B — Data governance for AI

**This is where the most damaging mistakes occur, and they are usually made once, early, and
silently.**

| # | Control | Evidence of operation |
|:---:|---|---|
| B1 | Data classes permitted to be sent to a model are defined in writing | Written determination |
| B2 | Customer or regulated data requires an explicit decision before use as context or training input | Approval record |
| B3 | Retention by the model provider is understood and recorded for each service in use | Provider terms on file |
| B4 | Training or fine-tuning datasets have a documented origin | Dataset register |
| B5 | Output handling is defined where outputs may contain input-derived content | Written determination |

## Control C — Cost accountability for AI workloads

| # | Control | Evidence of operation |
|:---:|---|---|
| C1 | Accelerated compute and inference spend is attributable to an owner | Attribution coverage figure |
| C2 | Budgets and alerts cover AI services specifically | Budget configuration |
| C3 | Idle accelerated instances are reviewed at least monthly | Review record |
| C4 | Per-request or per-token costs are understood before a workload scales | Documented estimate |

## Control D — Operational discipline

| # | Control | Evidence of operation |
|:---:|---|---|
| D1 | Model and version in use are recorded per workload | Inventory |
| D2 | A defined path exists for changing model or version | Change record |
| D3 | Dependency on a single provider is a recorded decision, not an accident | Written position |

---

## Maturity extension

These four controls extend the Component 1 instrument as an optional sixth domain, scored on the
same 0–4 rubric. Score it only where AI workloads are actually in use; an organization with none
marks the domain N/A rather than zero.

| Domain | Indicators | Scored |
|---|---|---|
| AI workload governance | A1–A4, B1–B5, C1–C4, D1–D3 | 0–4 per indicator |

---

## Relationship to federal AI policy

Executive Order 14179 of January 23, 2025, *Removing Barriers to American Leadership in Artificial
Intelligence*, established sustaining American AI leadership as national policy, and *Winning the
Race: America's AI Action Plan*, published July 23, 2025, sets out the resulting policy programme
across three pillars — accelerating AI innovation, building American AI infrastructure, and leading
in international AI diplomacy and security. Among its recommendations, the Action Plan encourages
open-source and open-weight development to promote innovation and commercial adoption.

**This component takes no position on AI regulation, and nothing here imposes obligations.** It is
published in the same form as the rest of the framework: openly licensed artifacts that an
organization may adopt, adapt, or ignore. The connection to federal policy is that this material is
released openly, which is the posture the Action Plan encourages, and that it addresses the segment
least equipped to build such governance independently.

---

*MIT licensed — see the [repository LICENSE](../LICENSE).*
