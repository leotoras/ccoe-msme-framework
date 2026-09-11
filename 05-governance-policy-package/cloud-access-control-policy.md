# Cloud Access Control and Identity Governance Policy

**Template — Component 5 of the MSME Cloud Governance Framework**

---

## How to use this template

This is written to be **completed and issued**, not read and admired. Every decision the adopting
organization must make appears in `[SQUARE BRACKETS]`. Work through them in order, delete this
instruction block, and issue the result.

**Before you start, decide three things:**

1. **Who approves access.** One named role. If the answer is "it depends," the policy will not
   hold. Pick the person who is accountable when access is wrong.
2. **How often you review.** Quarterly is a reasonable default for an SME. Annually is defensible
   for a very small organization. Choosing a cadence you will not honor is worse than choosing a
   longer one you will.
3. **What your exception path is.** There will be exceptions. A policy with no exception path gets
   ignored rather than followed; a policy with a documented one gets followed with recorded
   exceptions.

**Scope note.** This policy covers identity and access. It deliberately does not cover data
classification, incident response, or acceptable use — those are separate policies, and combining
them produces a document nobody reads. Keep them separate.

**This is not legal advice.** If your organization is subject to sector-specific regulation
(HIPAA, PCI-DSS, CMMC, SOC 2, state privacy law), have counsel or your auditor review this before
issuing. The template is a starting point, not a compliance artifact.

---
---

# Cloud Access Control and Identity Governance Policy

| | |
|---|---|
| **Organization** | `[ORGANIZATION NAME]` |
| **Policy owner** | `[ROLE — e.g., IT Director]` |
| **Approved by** | `[NAME, ROLE]` |
| **Effective date** | `[DATE]` |
| **Review cadence** | `[ANNUAL / SEMI-ANNUAL]` |
| **Next review** | `[DATE]` |
| **Version** | 1.0 |

---

## 1. Purpose

This policy establishes how identities are created, granted access, reviewed, and removed across
`[ORGANIZATION NAME]`'s cloud environments. Its objective is that every person and system holding
access to organizational cloud resources holds only the access their role requires, that this
access is recorded and reviewable, and that it is removed promptly when no longer needed.

## 2. Scope

This policy applies to:

- All cloud platform accounts, subscriptions, and projects owned or operated by the organization,
  including `[AWS / MICROSOFT AZURE / GOOGLE CLOUD — list all in use]`
- All employees, contractors, vendors, and third parties granted access to those environments
- All non-human identities, including service accounts, application credentials, CI/CD pipeline
  identities, and API keys

This policy does not cover physical access, on-premises systems not integrated with cloud
identity, or end-user SaaS applications outside the platform accounts listed above.

## 3. Roles and responsibilities

| Role | Responsibility |
|---|---|
| `[ACCESS APPROVER ROLE]` | Approves all access grants and changes. Accountable for the access decisions recorded under this policy. |
| `[ADMINISTRATOR ROLE]` | Implements approved access changes. Does not self-approve. |
| `[POLICY OWNER ROLE]` | Maintains this policy, runs access reviews, reports exceptions. |
| All users | Comply with this policy; report suspected credential compromise immediately. |

> **The separation between approver and administrator matters.** Where the organization is too
> small for genuine separation, name the compensating control here instead — for example, that all
> access changes are logged and reviewed by `[ROLE]` at the next scheduled review. Do not silently
> collapse the two roles.

## 4. Policy statements

### 4.1 Least privilege

Access is granted at the minimum level required to perform the assigned role. Broad standing
administrative access is not granted as a default, a convenience, or a substitute for defining
what a role actually requires.

### 4.2 Role-based access

Access is granted through defined roles rather than assembled per individual. Where a new role is
required, it is defined, documented, and approved before first assignment.

### 4.3 Multi-factor authentication

Multi-factor authentication is required for:

- All human access to cloud platform consoles, without exception
- All access to privileged or administrative roles
- `[ANY ADDITIONAL SCOPE — e.g., all remote access, all access to production]`

Accounts that cannot support MFA are not granted interactive console access.

### 4.4 Privileged and root credentials

Root, global administrator, and equivalent break-glass credentials are:

- Not used for routine work
- Protected by MFA
- Stored in `[PASSWORD MANAGER / SEALED ENVELOPE / SPECIFY]` with access restricted to `[ROLE]`
- Configured to alert `[ROLE OR DISTRIBUTION LIST]` on use

Use of these credentials requires documented justification recorded within `[TIMEFRAME — e.g.,
one business day]` of use.

### 4.5 Non-human identities

Service accounts, application credentials, and pipeline identities:

- Are created only through the process in section 5.1
- Are scoped to the specific resources the workload requires
- Are owned by a named human role accountable for their continued need
- Use short-lived or federated credentials where the platform supports it, in preference to
  long-lived static keys
- Where long-lived keys are unavoidable, are rotated every `[ROTATION PERIOD — e.g., 90 days]`

### 4.6 Shared credentials

Shared user accounts are prohibited. Where a legitimate technical constraint requires a shared
credential, it is treated as a non-human identity under section 4.5, documented as an exception
under section 6, and reviewed at every access review.

### 4.7 Third-party and vendor access

Third-party access is:

- Granted only for a defined purpose and a defined period
- Scoped to the minimum resources required
- Recorded with the sponsoring internal owner named
- Reviewed at every access review and removed when the engagement ends

## 5. Access lifecycle

### 5.1 Granting access

1. Access is requested through `[REQUEST MECHANISM — ticket system, form, email to a defined address]`
2. The request records: identity, role requested, business justification, and duration if temporary
3. `[ACCESS APPROVER ROLE]` approves or denies, and the decision is recorded
4. `[ADMINISTRATOR ROLE]` implements the approved grant
5. The record is retained for `[RETENTION PERIOD — e.g., 24 months]`

Verbal, chat, or hallway approvals are not valid grants under this policy.

### 5.2 Changing access

Role changes follow the same path as new grants. Access from the previous role is removed as part
of the change rather than left in place — accumulated access from prior roles is one of the most
common causes of over-privilege.

### 5.3 Removing access

Access is revoked within `[TIMEFRAME — e.g., 24 hours]` of:

- Termination of employment or engagement
- A role change that no longer requires the access
- Expiry of temporary or third-party access
- Suspected credential compromise

`[ROLE — typically HR or the engaging manager]` notifies `[ADMINISTRATOR ROLE]` of departures.
Where possible, revocation is triggered automatically by the identity provider.

### 5.4 Access review

`[POLICY OWNER ROLE]` conducts a review every `[REVIEW CADENCE — e.g., quarter]` covering:

- All human identities with access, and the roles they hold
- All non-human identities, and whether the workload still exists
- All third-party access, and whether the engagement is still active
- All exceptions recorded under section 6

Each entry is confirmed as still required or revoked. The review is recorded, including the
reviewer, date, and any access removed. **A review that confirms everything and removes nothing,
repeatedly, is a signal the review is not being performed substantively.**

## 6. Exceptions

Exceptions to this policy require:

- Documented business justification
- Approval by `[EXCEPTION APPROVER — should be more senior than the standard access approver]`
- A defined expiry date, not exceeding `[MAXIMUM EXCEPTION PERIOD — e.g., 12 months]`
- A compensating control where one is available
- Review at each scheduled access review

Exceptions are recorded in `[EXCEPTION REGISTER LOCATION]`. An exception that has expired without
renewal is treated as a violation.

## 7. Compliance and enforcement

Failure to comply may result in revocation of access and `[DISCIPLINARY CONSEQUENCE PER
ORGANIZATION'S HR POLICY]`.

Suspected credential compromise must be reported to `[CONTACT]` immediately. Reporting a
compromise promptly and in good faith will not itself result in disciplinary action — the
objective is that people report rather than conceal.

## 8. Related documents

- `[CLOUD SECURITY BASELINE STANDARD — see Component 2 of this framework]`
- `[INCIDENT RESPONSE PLAN]`
- `[ACCEPTABLE USE POLICY]`
- `[DATA CLASSIFICATION POLICY]`

## 9. Review and revision history

| Version | Date | Author | Summary of change |
|---|---|---|---|
| 1.0 | `[DATE]` | `[NAME]` | Initial issue |

---

## Appendix A — Adoption checklist

Work through this before issuing. The policy is not in force until these are true.

- [ ] Every `[BRACKETED FIELD]` above has been completed or deliberately removed
- [ ] The access approver role is named and that person has agreed to it
- [ ] The request mechanism in 5.1 exists and people know where it is
- [ ] The exception register in section 6 exists
- [ ] A first access review has been scheduled, with a date and an owner
- [ ] The policy has been approved by `[APPROVER]` and communicated to all users with cloud access
- [ ] Where the organization is subject to sector regulation, counsel or the auditor has reviewed it

---

## Appendix B — Mapping to the maturity assessment

Adopting and operating this policy moves the following indicators from
[Component 1](../01-cloud-maturity-assessment/):

| Indicator | Effect |
|---|---|
| **1.1** Named ownership | Section 3 names the accountable role |
| **1.3** Provisioning process | Section 5.1 defines the access grant path |
| **2.3** Identity hardening | Sections 4.3 and 4.4 |
| **2.4** Least privilege | Sections 4.1, 4.2, and 5.4 |
| **5.1** Defined responsibilities | Section 3 |

Writing the policy alone moves these indicators to **2 (Defined)**. Reaching **3 (Managed)**
requires evidence that the access review in 5.4 actually happened — which is why the review is
specified to produce a record.

---

*MIT licensed — see the [repository LICENSE](../LICENSE). Adapt freely; attribution appreciated,
not required.*
