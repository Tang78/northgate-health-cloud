# Runbook: <task name>

> **The test for a good runbook:** could a competent colleague who has never done this
> follow it successfully at 03:00, under pressure, without calling you? Write for that
> person. Assume they are capable and tired, not stupid and rested.

| | |
|---|---|
| **Runbook ID** | RB-NNN |
| **Version** | |
| **Last reviewed** | |
| **Last tested** | _(A runbook that has never been executed is a draft, not a runbook)_ |
| **Author** | |
| **Estimated duration** | |
| **Risk level** | Low / Medium / High |
| **Requires change approval** | Yes / No |
| **Business impact during execution** | |

---

## 1. Purpose

What this procedure does and when you would use it. Include the symptom or trigger that
leads someone here.

## 2. When NOT to use this

Situations where this procedure is the wrong response, and what to do instead. This
section prevents more incidents than the procedure itself.

## 3. Prerequisites

| Requirement | Detail |
|---|---|
| Access required | Specific role, at what scope |
| Tools required | With versions |
| Information needed before starting | |
| Maintenance window required | |
| Approvals required | |

## 4. Pre-checks

Confirm these before making any change. If any fails, stop and escalate.

- [ ]
- [ ]
- [ ]

## 5. Procedure

> Number every step. One action per step. Include the exact command. State the expected
> result so the operator can tell whether it worked.

### Step 1 — <action>

```powershell

```

**Expected result:**

**If this fails:**

### Step 2 — <action>

```powershell

```

**Expected result:**

**If this fails:**

## 6. Validation

How to confirm the task actually succeeded — not that the command returned zero, but
that the *service* is working from a user's point of view.

- [ ]
- [ ]

## 7. Rollback

> Every runbook that changes something needs this section. Write it before you need it.

**Rollback trigger — the point at which you stop trying and revert:**

**Rollback procedure:**

1.

**Expected rollback duration:**

## 8. Post-execution

- [ ] Change record updated
- [ ] Monitoring confirmed healthy
- [ ] Stakeholders notified
- [ ] Documentation updated if the procedure differed from what is written here

## 9. Escalation

| Situation | Escalate to | Contact |
|---|---|---|
| | | |

## 10. Related

- Related runbooks:
- Related ADRs:
- Related incidents:

---

## Execution log

| Date | Executed by | Outcome | Duration | Notes / deviations from procedure |
|---|---|---|---|---|
| | | | | |

> Logging executions is what turns a document into an operational artifact. Deviations
> recorded here are how the runbook improves.
