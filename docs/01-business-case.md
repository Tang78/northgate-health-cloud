# Business Case
## Infrastructure Modernization — Northgate Health Partners

> **TEMPLATE.** Replace every `_(...)_` prompt. Target 4-6 pages. This document must
> survive scrutiny from the CFO on numbers and from the Senior Sysadmin on technical
> claims. Write it for a board that will vote on it.

| | |
|---|---|
| **Document ID** | NHP-BC-001 |
| **Version** | 1.0 |
| **Date** | _(fill in)_ |
| **Author** | _(your name)_, Technology Analyst |
| **Sponsor** | Ray Okonkwo, CFO |
| **Status** | Draft for board review |
| **Decision required by** | _(date)_ |
| **Related documents** | NHP-ASM-001 Current State Assessment · `docs/tco-model.xlsx` |

---

## 1. Executive summary

> _(One page maximum. If a board member reads only this, they must be able to vote.
> Structure: situation in two sentences, the problem in two, the recommendation in one,
> the cost, the benefit, the main risk, and exactly what you are asking for.)_

**Situation.** _( )_

**Problem.** _( )_

**Recommendation.** _( )_

**Financial impact.** _(Five-year cost of the recommended option versus the alternatives,
in a single sentence with the numbers.)_

**Principal risk and mitigation.** _( )_

**Decision requested.** _(Be specific: approve $X of migration funding, approve not
renewing the server room space, approve the phased roadmap, delegate authority to
proceed with Phase 1.)_

---

## 2. Background and drivers

| # | Driver | Evidence | Deadline |
|---|---|---|---|
| D-1 | Head office lease expires; renewal quoted 40% higher; executive decision not to renew | _(lease document)_ | 14 months |
| D-2 | Ransomware risk; the board cannot currently be told when services would be restored | _(TransForm SSO 2023, NL Health 2021, LifeLabs 2019)_ | Ongoing |
| D-3 | Five open PHIPA assessment findings requiring documented remediation | _(assessment report)_ | Follow-up assessment _(date)_ |
| D-4 | ClinicSchedule performance degradation during morning check-in, raised at three consecutive quality meetings | _(quality meeting minutes)_ | Ongoing |
| D-5 | Riverside Family Care acquisition — 3 clinics, 90 staff, separate EMR and AD forest | _(board papers)_ | ~7 months |

---

## 3. Problem statement

_(What happens if nothing is done. Be concrete and sequence it against the timeline.
The lease expires and there is nowhere to put the servers. The hardware is out of
warranty and the spares are gone. The findings stay open into a follow-up assessment.
The acquisition arrives with no capacity to absorb it. Name the dates.)_

---

## 4. Objectives and success criteria

Every criterion must be measurable and testable.

| # | Objective | Success criterion | Measured by |
|---|---|---|---|
| O-1 | Exit the head office server room before lease expiry | Zero production workloads on head office hardware by _(date)_ | Infrastructure inventory |
| O-2 | Establish a proven recovery capability | A documented, **tested** RTO of 1 hour and RPO of 15 minutes for ClinicSchedule during clinic hours | DR test report |
| O-3 | Close the five PHIPA findings | All five findings closed with documented evidence acceptable to the Privacy Officer | Follow-up assessment |
| O-4 | Resolve the morning performance degradation | ClinicSchedule 95th-percentile page response under _(N)_ seconds between 07:45 and 09:15 | Application monitoring |
| O-5 | Establish capacity to absorb the acquisition | A costed, sequenced integration plan and an environment that scales to 9 clinics without redesign | Integration assessment |
| O-6 | Operate within a predictable cost envelope | Monthly Azure spend within ±10% of forecast for three consecutive months | Cost management reporting |

---

## 5. Options considered

> Give each option a fair hearing. An options analysis with four strawmen is transparent
> and it damages your credibility with exactly the people you are trying to persuade.

### Option 1 — Renew the lease and continue as-is

**Description.** _( )_
**Five-year cost.** _( )_
**Advantages.** _( )_
**Disadvantages.** _( )_
**Risks.** _( )_
**Assessment.** _( )_

### Option 2 — Hardware refresh into a smaller on-premises space

**Description.** _( )_
**Five-year cost.** _( )_
**Advantages.** _( )_
**Disadvantages.** _( )_
**Risks.** _( )_
**Assessment.** _( )_

### Option 3 — Colocation

**Description.** _(Move the physical servers to rented rack space in a commercial
datacentre. Solves the facility problem without changing the operating model.)_
**Five-year cost.** _( )_
**Advantages.** _(Genuine power, cooling, fire suppression and physical security.
Minimal application change. Familiar operating model.)_
**Disadvantages.** _(Still owns and refreshes hardware. Still no elasticity. Still
carries the sysadmin burden. Remote hands costs. Still needs a DR site.)_
**Risks.** _( )_
**Assessment.** _( )_

### Option 4 — Full migration to Azure

**Description.** _( )_
**Five-year cost.** _( )_
**Advantages.** _( )_
**Disadvantages.** _(Some workloads genuinely cannot move. This option requires
pretending otherwise, which is why it is not the recommendation.)_
**Risks.** _( )_
**Assessment.** _( )_

### Option 5 — Hybrid migration to Azure *(recommended)*

**Description.** _(Migrate what makes sense, retain what does not, connect them.
Active Directory remains on-premises for domain-joined workstations. MediTrack remains
SaaS. ClinicSchedule, file services, the lab interface and billing move to Azure.)_
**Five-year cost.** _( )_
**Advantages.** _( )_
**Disadvantages.** _( )_
**Risks.** _( )_
**Assessment.** _( )_

### Options summary

| Option | 5-year cost | Meets O-1 | Meets O-2 | Meets O-3 | Meets O-5 | Recommendation |
|---|---|---|---|---|---|---|
| 1. Renew | | No | No | Partial | No | Reject |
| 2. Refresh | | Partial | No | Partial | Partial | Reject |
| 3. Colocation | | Yes | Partial | Partial | Partial | Reject |
| 4. Full Azure | | Yes | Yes | Yes | Yes | Not achievable |
| 5. **Hybrid Azure** | | **Yes** | **Yes** | **Yes** | **Yes** | **Recommended** |

---

## 6. Recommended option and rationale

_(Two or three paragraphs. Why hybrid Azure, tied explicitly back to the drivers and
the objectives. Do not restate the option description — argue for it.)_

---

## 7. Financial analysis

### 7.1 Five-year comparison

| Year | Option 1 Renew | Option 2 Refresh | Option 3 Colo | Option 5 Hybrid Azure |
|---|---|---|---|---|
| Year 1 | | | | |
| Year 2 | | | | |
| Year 3 | | | | |
| Year 4 | | | | |
| Year 5 | | | | |
| **Cumulative** | | | | |

_(Insert the cumulative cost chart from `docs/tco-model.xlsx`.)_

### 7.2 One-time migration costs

| Item | Cost | Notes |
|---|---|---|
| External migration assistance | | |
| Training | | |
| Dual-running during transition | | |
| Application remediation (ClinicSchedule) | | |
| Secure decommissioning and data destruction | | **PHIPA requirement — certificates of destruction needed** |
| Contingency (_(N)_%) | | |

### 7.3 Cost optimization applied

| Lever | Estimated saving | Applied to |
|---|---|---|
| Azure Hybrid Benefit | | Windows Server and SQL Server workloads |
| 3-year Reserved Instances | | Steady-state compute |
| Auto-shutdown on non-production | | Dev/test |
| Storage lifecycle tiering | | Archived clinical documents |

### 7.4 Sensitivity analysis

> **This is the section that makes the case credible.** Anyone can produce a number that
> favours their recommendation. Showing the recommendation still holds when your estimate
> is wrong is what persuades a CFO.

| Scenario | Impact on 5-year cost | Does the recommendation still hold? |
|---|---|---|
| Azure costs 30% more than estimated | | |
| Migration takes twice as long | | |
| Downtime cost is half our estimate | | |
| Riverside acquisition adds 50% more workload | | |
| No Azure Hybrid Benefit available | | |

### 7.5 What is known versus estimated

_(Be explicit. Which figures came from an invoice or a quote, and which are your estimate?
State the confidence level. This paragraph buys you enormous credibility.)_

---

## 8. Risk assessment

### 8.1 Risks of proceeding

| ID | Risk | L | I | Score | Mitigation | Owner |
|---|---|---|---|---|---|---|
| PR-01 | **Site internet becomes a single point of failure for all clinical systems** | | | | Redundant carrier circuits at head office; LTE/5G failover at clinics; documented offline fallback procedure | |
| PR-02 | ClinicSchedule cannot be migrated as-is | | | | Assessment in Phase 1 before commitment; remediation budget held in contingency | |
| PR-03 | Cost overrun from unmanaged consumption | | | | Budgets, Azure Policy on SKUs and regions, monthly cost review, tagging for allocation | |
| PR-04 | Skills gap in the IT team | | | | Training budget; external partner for Phase 1; knowledge transfer as a contractual deliverable | |
| PR-05 | Migration causes clinical disruption | | | | Cutover in maintenance windows; rollback plan with a defined trigger point; pilot at one clinic first | |
| PR-06 | Vendor lock-in | | | | Infrastructure as code; IaaS-first for portable workloads; exit plan documented | |
| PR-07 | Key person dependency during migration | | | | Documentation as a deliverable, not an afterthought | |

### 8.2 Risks of not proceeding

_(Reference the current state assessment risk register. Summarize the top five.)_

---

## 9. Concerns raised during consultation

> Address these seriously. Frame them as consultation rather than rebuttal — it is both
> more accurate and more effective.

### 9.1 "Cloud is more expensive than owning the hardware"

**Raised by:** Tom Braddock, Senior Systems Administrator

**The concern is partly valid.** _( )_

**Response.** _(Concede where he is right — for a steady 24/7 workload on depreciated
hardware with staff already on payroll, on-premises can be cheaper. Then explain why
Northgate's situation differs: the hardware is not depreciated-and-fine, it is out of
warranty and due for replacement; the facility cost is about to increase or disappear;
and 35% of a senior sysadmin's time is embedded in the current model. Reference the
sensitivity analysis showing the case holds at +30%.)_

### 9.2 "We lose control — when it breaks I can't walk into the server room"

**Response.** _(Concede the loss of physical access. Note what is gained: API access,
monitoring that does not exist today, and a support contract. Then the honest counter —
today when it breaks at 2am, Tom drives to Oshawa. That is not control, it is an
obligation, and it is a key person dependency.)_

### 9.3 "Our internet connection is a single point of failure"

> **He is right, and this is the most important objection in the document.**

**Response.** _(Do not deflect this. Today, if the Oshawa internet fails, the Oshawa
clinic still reaches ClinicSchedule over the LAN. Under the recommended architecture,
no site reaches it. This is a genuine new risk introduced by the recommendation.
Then: cost the mitigation — redundant carrier circuits, LTE/5G failover, documented
offline fallback — and include it in the financial analysis. Show it as risk PR-01.)_

**Mitigation cost included in the financial analysis:** $_( )_ per year.

### 9.4 "We'll be locked into Microsoft"

**Response.** _(Distinguish IaaS portability from PaaS coupling from SaaS coupling.
Note that Northgate is already deeply committed to Microsoft through Active Directory
and Microsoft 365, so the marginal lock-in is smaller than it appears. Note that
infrastructure as code reduces it further. Note that lock-in also exists today with the
hardware vendor and with MediTrack.)_

---

## 10. Impact on compliance

| Finding | Current status | Impact of recommendation | Evidence produced |
|---|---|---|---|
| F-01 Ad-hoc access authorization | Open | _( )_ | RBAC model, role matrix, access request process |
| F-02 Shared admin accounts | Open | _( )_ | Individual accounts, PIM, audit logs |
| F-03 No access reviews | Open | _( )_ | Entra ID access reviews, quarterly evidence |
| F-04 No retention schedule | Open | _( )_ | Retention policy, immutable storage, lifecycle rules |
| F-05 No audit logging | Open | _( )_ | Log Analytics with defined retention, queryable audit trail |

**Note on custodian accountability:** _(Migrating to Azure does not transfer Northgate's
obligations under PHIPA. Northgate remains the health information custodian. Microsoft
provides platform compliance; Northgate retains accountability for identity, access,
classification and use.)_

---

## 11. High-level roadmap

| Phase | Timing | Scope | Key outcome | Gate |
|---|---|---|---|---|
| 0 — Foundation | Months 1-2 | Governance, network, identity | Landing zone ready | Design approved |
| 1 — Pilot | Months 2-4 | ClinicSchedule migration | Proven migration approach | Pilot clinic signed off |
| 2 — Data and files | Months 4-7 | File shares, database, retention | PHIPA findings F-04 closed | Restore tested |
| 3 — Integration | Months 6-9 | Lab interface, billing | Silent-failure risk eliminated | Reconciliation proven |
| 4 — Operations | Months 8-11 | Monitoring, security, governance | Findings F-01/02/03/05 closed | Follow-up assessment passed |
| 5 — Resilience | Months 10-12 | Backup, DR, tested failover | Board's ransomware question answered | DR test report |
| 6 — Decommission | Months 12-14 | Server room exit, secure disposal | Lease exit | Certificates of destruction |

_(Show this against the 14-month lease deadline and the 7-month acquisition date. Identify
where they collide.)_

---

## 12. Resourcing

| Role | Source | Effort | Cost |
|---|---|---|---|
| Technology Analyst (you) | Internal | | |
| Senior Sysadmin | Internal, part-time | | |
| Cloud migration partner | External | | |
| Privacy Officer review | Internal | | |
| Training | External | | |

**Skills gap:** _( )_

---

## 13. Recommendation and decision requested

_(State exactly what you want. Not "approve the cloud strategy" but the specific decisions:
approve $X for Phase 0 and Phase 1; confirm the server room will not be renewed; approve
the redundant connectivity investment; delegate Phase 2-6 approval to the CFO subject to
Phase 1 outcomes.)_

---

## 14. Appendices

- **Appendix A** — Current State Assessment (NHP-ASM-001)
- **Appendix B** — TCO model (`docs/tco-model.xlsx`)
- **Appendix C** — Azure pricing calculator estimates
- **Appendix D** — Target state architecture (indicative)

---

## Revision history

| Version | Date | Author | Change |
|---|---|---|---|
| 1.0 | _( )_ | _( )_ | Initial draft for board review |
