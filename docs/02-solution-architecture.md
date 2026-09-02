# Solution Architecture
## Northgate Health Partners — Azure Target State

> **Living document.** Started in Week 1 and extended every week as each layer is
> designed and built. Completed and consolidated in Week 12, where it becomes the
> master 25-40 page deliverable.
>
> Do not try to write it all now. Add the section for each layer as you finish that
> week, and update the diagram. Watching this document grow from a page to a real
> architecture over twelve weeks is part of the portfolio value.

| | |
|---|---|
| **Document ID** | NHP-ARC-002 |
| **Version** | 0.1 (Week 1) |
| **Date** | _( )_ |
| **Author** | _(your name)_, Technology Analyst |
| **Status** | In progress — updated weekly |

---

## 1. Executive summary

_(Week 12. Write this last.)_

## 2. Business context

_(Week 1. Summarize from the business case — the five drivers, the deadlines, the
constraints. Two or three paragraphs.)_

## 3. Requirements

### 3.1 Functional requirements

_(Week 1-2)_

| ID | Requirement | Source | Priority |
|---|---|---|---|
| FR-01 | | | |

### 3.2 Non-functional requirements

_(Week 1. Availability, performance, capacity, recoverability. These come from the
business, not from what Azure can do.)_

| ID | Requirement | Target | Source |
|---|---|---|---|
| NFR-01 | ClinicSchedule availability during clinic hours | 99.9% measured Mon-Fri 07:00-19:00 and Sat 08:00-14:00 Eastern, excluding announced maintenance | CMO |
| NFR-02 | ClinicSchedule RTO during clinic hours | 1 hour | CMO |
| NFR-03 | ClinicSchedule RPO | 15 minutes | CMO |
| NFR-04 | Lab results interface — data loss | Zero tolerated | CMO, patient safety |
| NFR-05 | | | |

### 3.3 Compliance requirements

_(Week 1, extended in Week 10)_

| ID | Requirement | Source |
|---|---|---|
| CR-01 | Personal health information stored in Canada | Internal privacy policy, data sharing agreements |
| CR-02 | Audit logging retained for systems holding PHI | PHIPA assessment finding F-05 |
| CR-03 | | |

## 4. Architecture principles

_(Week 1. Five to eight statements that guide every subsequent decision. Each should be
specific enough that it could plausibly be violated. "We will use best practices" is not
a principle.)_

1. **Data residency is non-negotiable.** All PHI at rest remains in Canadian Azure regions.
2. **Availability requirements derive from clinic operating hours,** not from 24/7 assumptions.
3. **Prefer platform services over infrastructure services** where the application permits, to reduce operational burden on a four-person team.
4. **Everything is defined in code from Week 8.** Manual portal changes are drift and are treated as incidents.
5. **Least privilege by default.** Standing administrative access is an exception requiring justification.
6. _( )_

## 5. Logical architecture

_(Week 3 onward. The diagram plus a description of each layer and how they relate.)_

## 6. Physical architecture

_(Week 3 onward)_

## 7. Network design

_(Week 3 — summarize and link to `05-network-design.md`)_

## 8. Compute design

_(Week 2)_

## 9. Identity and access design

_(Week 4 — summarize and link to `04-identity-and-access-design.md`)_

## 10. Data and storage design

_(Weeks 5-6)_

## 11. Integration design

_(Week 7 — summarize and link to `07-integration-specification.md`)_

## 12. Monitoring and operations design

_(Week 9 — summarize and link to `08-monitoring-and-alerting-design.md`)_

## 13. Security and governance design

_(Week 10 — summarize and link to `09-governance-framework.md`)_

## 14. Business continuity design

_(Week 11 — summarize and link to `10-disaster-recovery-plan.md`)_

## 15. Key decisions

_(Week 12. A table of every ADR with a one-line summary and a link. Do not repeat the
reasoning here — the ADR is the reasoning.)_

| ADR | Decision | Summary |
|---|---|---|
| [0001](../adr/0001-record-architecture-decisions.md) | Record architecture decisions | Lightweight ADRs for every significant decision |
| [0002](../adr/0002-azure-region-selection.md) | Canada Central primary, Canada East secondary | Data residency drives the choice; DR region has no availability zones |

## 16. Cost model

_(Week 11)_

## 17. Descoped and deferred

_(Week 12. What you deliberately did not do, and why. This section signals judgement.)_

## 18. Twelve-month roadmap

_(Week 12)_
