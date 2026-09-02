# INC-NNN: <short description of the symptom, not the cause>

> Name the incident after the **symptom**, because at the point you open the file you do
> not yet know the cause. "INC-002 ClinicSchedule unreachable" not "INC-002 NSG misconfiguration".

| | |
|---|---|
| **Incident ID** | INC-NNN |
| **Severity** | Sev 1 / Sev 2 / Sev 3 / Sev 4 |
| **Status** | Open / Mitigated / Resolved / Closed |
| **Detected** | YYYY-MM-DD HH:MM — and *how* it was detected |
| **Mitigated** | YYYY-MM-DD HH:MM |
| **Resolved** | YYYY-MM-DD HH:MM |
| **Time to detect (MTTD)** | |
| **Time to resolve (MTTR)** | |
| **Systems affected** | |
| **Users affected** | |
| **Data affected** | Include whether PHI was involved — this changes the obligations |
| **Author** | |

---

## 1. Summary

Two or three sentences. What happened, who it affected, how long it lasted, and what the
cause turned out to be. A reader should be able to stop here and understand the incident.

## 2. Impact

Quantify it. Vague impact statements are the reason incidents do not get funded fixes.

| Dimension | Impact |
|---|---|
| Duration | |
| Users affected | |
| Business function affected | |
| Financial impact | |
| Clinical impact | Was patient care affected? Was any care delayed or a result missed? |
| Data loss | |
| Privacy impact | Was PHI exposed, accessed or lost? If yes, the breach procedure applies. |
| SLO consumed | |

## 3. Timeline

All times in Eastern. Include what you checked and what you ruled out, not only what you
found. **A timeline with no dead ends in it is not a real timeline** and an experienced
reader will notice.

| Time | Actor | Event |
|---|---|---|
| HH:MM | | Alert received / user reported |
| HH:MM | | Acknowledged, began investigation |
| HH:MM | | Checked X. Ruled out Y. |
| HH:MM | | Checked Z. Found anomaly. |
| HH:MM | | Hypothesis formed |
| HH:MM | | Hypothesis tested — disproved. Returned to investigation. |
| HH:MM | | Root cause identified |
| HH:MM | | Mitigation applied |
| HH:MM | | Service confirmed restored — state how you confirmed it |
| HH:MM | | Stakeholders notified of resolution |

## 4. Investigation

Describe the diagnostic path in prose. What was your reasoning at each step? What tools
did you use? Which hypotheses did you form and how did you test them?

Include the actual evidence — commands run, queries executed, screenshots, log extracts,
metric charts.

```
# commands run
```

```kusto
// queries used
```

## 5. Root cause

The single technical cause, stated precisely.

Then ask "why" at least three more times until you reach the **systemic** cause. The
technical cause is why it broke; the systemic cause is why it was possible for it to break.

- **Technical cause:**
- **Why was that possible?**
- **Why was that not caught?**
- **Why was that not prevented?**
- **Systemic cause:**

## 6. Contributing factors

Things that were not the cause but made it worse, made it slower to detect, or made it
harder to diagnose.

-

## 7. What went well

Genuinely include this. Post-incident reviews that only list failures teach the team that
the process is punitive, and people stop reporting incidents honestly.

-

## 8. What went badly

-

## 9. Resolution

What was actually changed to restore service, and how you verified it worked.

## 10. Lessons learned

The section that has the most value six months later. Write these as transferable
principles, not as restatements of the fix.

-

## 11. Action items

| # | Action | Type | Owner | Due | Status |
|---|---|---|---|---|---|
| 1 | | Preventive / Detective / Corrective | | | Open |
| 2 | | | | | |

Classify each action:
- **Preventive** — stops it happening again
- **Detective** — catches it faster next time
- **Corrective** — reduces the impact when it does happen

A set of actions that is entirely detective means you have improved your alerting and
changed nothing about the underlying fragility.

## 12. Blameless statement

> This review is blameless. **If any part of this document names an individual as the
> cause, rewrite it.** The cause is always a system that permitted the outcome — a missing
> control, an absent test, an unclear procedure, an alert that did not exist. People
> operate inside the system they are given.

## 13. Appendices

- Screenshots
- Log extracts
- Related incidents
- Related ADRs
