# Current State Assessment
## Northgate Health Partners — IT Estate

> **TEMPLATE.** Replace every `_(...)_` prompt with your own content and delete this
> line when finished. Target length 4-6 pages. Where a table has example rows, keep
> them if they are accurate for the scenario and add your own.

| | |
|---|---|
| **Document ID** | NHP-ASM-001 |
| **Version** | 1.0 |
| **Date** | _(fill in)_ |
| **Author** | _(your name)_, Technology Analyst |
| **Status** | Draft |
| **Distribution** | IT Manager, CFO, Privacy Officer, CMO |
| **Related documents** | NHP-BC-001 Business Case · NHP-STD-003 Naming and Tagging Standard |

---

## 1. Executive summary

_(One paragraph. A non-technical reader must be able to read only this and know what
you found and how serious it is. Lead with the conclusion, not the method. Aim for
something like: "Northgate operates X business-critical systems from a converted supply
closet with no power redundancy, no tested backup, and no disaster recovery capability.
Y of Z servers are out of warranty. The estate costs approximately $A per year to
operate. We identified N risks, of which M are rated high or critical. Three systems
were found that were not previously documented by IT.")_

---

## 2. Scope

**In scope:** _(list)_

**Out of scope, and why:** _(e.g. clinical medical devices, the MediTrack vendor's own
infrastructure, workstations and printers, telephony)_

---

## 3. Method

_(State how you gathered this. Real assessments declare their method so the reader can
judge how much to trust the findings.)_

| Activity | Detail |
|---|---|
| Interviews | _(who, role, date, duration)_ |
| Physical inspection | _(server room walkthrough, date)_ |
| System inspection | _(what you logged into and looked at)_ |
| Document review | _(what documentation existed, and its quality)_ |
| Financial review | _(invoices, contracts, budget lines reviewed with Finance)_ |

**Confidence and limitations:** _(Where are your figures estimates rather than facts?
Say so. A document that distinguishes measured from estimated is far more trustworthy
than one that presents everything with equal certainty.)_

---

## 4. Organizational context

| Attribute | Detail |
|---|---|
| Sites | _(six clinics + HQ, list them)_ |
| Staff | _(~450, breakdown)_ |
| Rostered patients | ~120,000 |
| Daily patient visits | ~1,400 |
| Operating hours | Mon-Fri 07:00-19:00, Sat 08:00-14:00, closed Sunday |
| IT team | _(4 staff, roles)_ |
| IT operating budget | _(annual)_ |

**Why operating hours matter:** _(Make the point explicitly that availability requirements
are not 24/7 and that this materially changes the cost of resilience.)_

---

## 5. Systems inventory

| System | Purpose | Hosting model | Criticality | Users | Data classification | Business owner | Technical owner | Annual cost | Support | Known issues |
|---|---|---|---|---|---|---|---|---|---|---|
| MediTrack EMR | Clinical system of record | SaaS (vendor, Canadian DC) | Tier 1 | ~380 | PHI | CMO | Vendor | _( )_ | Vendor SLA | _( )_ |
| ClinicSchedule | Appointment booking and check-in | On-premises | Tier 1 | ~200 | PHI | Clinic Operations | Tom Braddock | _( )_ | None — developer no longer trading | _( )_ |
| OHIP Billing & Claims | Claim generation, MCEDT submission, RA ingestion | On-premises | Tier 1 | ~12 | PHI + financial | Finance | Tom Braddock | _( )_ | _( )_ | Silent batch failures |
| Lab Results Interface | Ingests results from 3 labs | On-premises | Tier 1 | n/a (automated) | PHI | CMO | Tom Braddock | _( )_ | None | Fragile parser, duplicates |
| File shares | Scanned records and department folders | On-premises | Tier 2 | ~450 | PHI | IT | Tom Braddock | _( )_ | _( )_ | Permissions unmanaged |
| Active Directory | Identity and authentication | On-premises | Tier 1 | ~450 | Internal | IT | Tom Braddock | _( )_ | _( )_ | Whitby DC replication failing |
| Microsoft 365 | Email, Teams, SharePoint | SaaS | Tier 1 | ~450 | Confidential | IT | Microsoft | _( )_ | E3 | Lightly governed |
| _(add the undocumented Access database you discovered)_ | | | | | | | | | | |

---

## 6. Infrastructure inventory

| Server | Role | Hardware | Age | Warranty | OS | Support status | CPU | RAM | Storage | Utilization |
|---|---|---|---|---|---|---|---|---|---|---|
| _( )_ | ClinicSchedule web / IIS | _( )_ | _( )_ | **Expired 2022** | Windows Server 2016 | _(check EOL)_ | _( )_ | _( )_ | _( )_ | _( )_ |
| _( )_ | ClinicSchedule SQL | _( )_ | _( )_ | **Expired 2022** | Windows Server 2016 / SQL 2016 | _( )_ | _( )_ | _( )_ | _( )_ | _( )_ |
| _( )_ | OHIP billing batch | | | | | | | | | |
| _( )_ | SFTP / lab interface | | | | | | | | | |
| _( )_ | File server (~4 TB) | | | | | | | | | |
| _( )_ | Domain controller (HQ) | | | | | | | | | |
| _( )_ | MediTrack reporting replica | | | | | | | | | |

**Utilization observation:** _(Make the virtualization point — what is the average CPU
utilization across the estate, and what does that say about how much hardware is being
paid for versus used?)_

---

## 7. Facility assessment

_(The server room walkthrough. Be specific. Generic statements are worthless; measurements
and observations are findings.)_

| Aspect | Observed | Risk |
|---|---|---|
| Location | _(converted supply closet, 2nd floor)_ | _( )_ |
| Rack | _(24U wall-mounted, N servers)_ | _( )_ |
| Power | _(single circuit, shared with kitchenette)_ | _( )_ |
| UPS | _(1500VA, batteries last replaced 2019, ~11 min runtime)_ | _( )_ |
| Generator | None | _( )_ |
| Cooling | _(residential split unit, no redundancy, door propped open in summer)_ | _( )_ |
| Fire suppression | _(building water sprinkler directly above rack)_ | _( )_ |
| Physical access | _(master-keyed to all supply closets)_ | _( )_ |
| Environmental monitoring | None | _( )_ |
| Cabling and labelling | _( )_ | _( )_ |

**Photographs / observations:** _(reference appendix)_

---

## 8. Service model and shared responsibility mapping

| System | Model | Provider is responsible for | Northgate is responsible for |
|---|---|---|---|
| MediTrack EMR | SaaS | Application, platform, infrastructure, physical security | User accounts and access rights, data accuracy, staff use of data, audit review, contract terms |
| Microsoft 365 | SaaS | Service availability, platform security | Identity, licensing, retention, sharing configuration, data governance |
| ClinicSchedule | On-premises | Nothing | Everything, including the building |
| _(add rows for the target-state models to show the shift)_ | | | |

**The point to make explicitly:** _(Data, endpoints and identities remain Northgate's
responsibility in every model. Under PHIPA, Northgate is the health information custodian
and remains accountable to the Information and Privacy Commissioner of Ontario even
where a vendor holds the data.)_

---

## 9. Integration inventory

> This section is the seed of the Week 7 interface catalog. Do it properly now and
> Week 7 becomes much easier.

| ID | Source | Target | Direction | Method | Format | Frequency | Data classification | Criticality | Owner | Known problems |
|---|---|---|---|---|---|---|---|---|---|---|
| INT-01 | LifeLabs | Lab interface server | Inbound | SFTP | _(delimited file)_ | _( )_ | PHI | Tier 1 | _( )_ | Format change went undetected for 9 days |
| INT-02 | Dynacare | Lab interface server | Inbound | SFTP | _( )_ | _( )_ | PHI | Tier 1 | _( )_ | _( )_ |
| INT-03 | Lakeridge Health lab | Lab interface server | Inbound | _( )_ | HL7 v2 | _( )_ | PHI | Tier 1 | _( )_ | _( )_ |
| INT-04 | Lab interface server | MediTrack staging | Outbound | _( )_ | _( )_ | _( )_ | PHI | Tier 1 | _( )_ | Duplicate results |
| INT-05 | Billing server | OHIP (MCEDT) | Outbound | _( )_ | _( )_ | Monthly | PHI + financial | Tier 1 | _( )_ | Silent failure — $84k unsubmitted for 5 weeks |
| INT-06 | OHIP (MCEDT) | Billing server | Inbound | _( )_ | Remittance Advice | _( )_ | Financial | Tier 1 | _( )_ | _( )_ |
| INT-07 | MediTrack | Reporting replica | Inbound | Nightly export | _( )_ | Daily | PHI | Tier 2 | _( )_ | Full identifiers exposed to 34 users |
| INT-08 | ClinicSchedule | MediTrack | _( )_ | _( )_ | _( )_ | _( )_ | PHI | Tier 1 | _( )_ | _( )_ |

**Observation on integration architecture:** _(How many point-to-point interfaces exist?
What is the maintenance implication? What happens when a partner changes a format? Is
there any monitoring, reconciliation or error handling at all?)_

---

## 10. Current cost baseline

| Category | Item | Annual cost (CAD) | Source | Confidence |
|---|---|---|---|---|
| Hardware | Server refresh amortized over 5 years | _( )_ | _(quote / invoice / estimate)_ | _( )_ |
| Software | Windows Server licensing | _( )_ | | |
| Software | SQL Server licensing | _( )_ | | |
| Software | Backup software | _( )_ | | |
| Facility | Server room share of lease | _( )_ | | |
| Facility | Power and cooling | _( )_ | | |
| Facility | UPS replacement amortized | _( )_ | | |
| Support | Hardware maintenance contracts | _( )_ | | |
| Backup | Tape media | _( )_ | | |
| Backup | Offsite storage and courier | _( )_ | | |
| Staff | Sysadmin time on infrastructure (35% FTE loaded) | _( )_ | | |
| Staff | Service desk infrastructure time | _( )_ | | |
| Downtime | Estimated unplanned downtime cost | _( )_ | | |
| **Total** | | **_( )_** | | |

**Downtime calculation:** _(Show your working explicitly. This is the number that will
be challenged, so make it defensible. State the assumption, the method and the sensitivity.)_

---

## 11. Availability and continuity — current state

| System | Backup method | Backup tested? | Actual RTO today | Actual RPO today | Business requirement (RTO/RPO) | Gap |
|---|---|---|---|---|---|---|
| ClinicSchedule | _( )_ | **No** | _(unknown — days?)_ | _( )_ | 1 hr / 15 min in clinic hours | _( )_ |
| OHIP Billing | | | | | 3 days / 24 hr | |
| Lab interface | | | | | 4 hr / zero data loss | |
| File shares | | | | | 8 hr / 24 hr | |
| Active Directory | | | | | | |

**Key finding:** _(The tape backup has never had a restore tested. Recovery capability is
therefore unproven, and an unproven backup should be treated as no backup for planning
purposes. This is free to fix and should be done within 30 days regardless of the cloud
decision.)_

---

## 12. Compliance — current state

| Finding | Description | Status | Systems affected | Notes |
|---|---|---|---|---|
| F-01 | Ad-hoc access authorization with no documented process | Open | All | |
| F-02 | Shared administrative accounts in use | Open | | |
| F-03 | No periodic access review; terminated staff accounts found active | Open | | |
| F-04 | No records retention or secure disposal schedule | Open | | |
| F-05 | Audit logging not enabled or retained on systems holding PHI | Open | | |

**Additional compliance observations found during this assessment:** _(e.g. the MediTrack
reporting replica accessible to 11 users with no clinical role — this is a live PHIPA
issue, not a future one.)_

---

## 13. Risk register

Scored as Likelihood (1-5) × Impact (1-5). 15+ is high, 20+ is critical.

| ID | Risk | Category | L | I | Score | Current controls | Recommendation |
|---|---|---|---|---|---|---|---|
| R-01 | Single power circuit and UPS batteries past service life; a head office power event takes all clinical systems offline | Availability | 4 | 5 | 20 | None | Migrate workloads to Azure; do not invest in the room |
| R-02 | Tape backup has never been restore-tested; recovery capability unproven | Continuity | 3 | 5 | 15 | Tape rotation exists | **Test a restore within 30 days regardless of the cloud decision** |
| R-03 | Water sprinkler directly above server rack | Availability | 2 | 5 | 10 | None | Accept until migration |
| R-04 | ClinicSchedule source code exists only on a file share; no version control, developer no longer trading | Supportability | 3 | 4 | 12 | None | **Place code under version control immediately — free to fix** |
| R-05 | OHIP claims batch fails silently; $84,000 unsubmitted for five weeks in March | Financial | 4 | 4 | 16 | Monthly reconciliation eventually catches it | Add monitoring and alerting |
| R-06 | _( )_ | | | | | | |

_(Aim for 12-18 risks. Cover: availability, security, compliance, financial, supportability,
key person dependency, vendor, and the risks introduced by the migration itself.)_

---

## 14. Findings and observations

_(The things nobody had documented. This section is your evidence that you did a real
assessment rather than transcribing what you were told.)_

**Finding 1 — Undocumented departmental system.** _( )_

**Finding 2 — Domain controller replication failure.** _( )_

**Finding 3 — Excessive access to identifiable patient data in the reporting replica.** _( )_

**Finding 4 — Key person dependency.** _( )_

**Finding 5 — _( )_**

---

## 15. Assumptions and constraints

| # | Assumption or constraint | Impact if wrong | Owner to confirm |
|---|---|---|---|
| A-01 | Head office lease will not be renewed | Timeline collapses | CFO |
| A-02 | ClinicSchedule can run on a supported Windows Server version | Migration approach changes materially | You, Week 2 |
| A-03 | Canadian data residency is required by contract and policy | Region options widen | Privacy Officer |
| A-04 | Riverside acquisition closes in ~7 months | Capacity and integration planning | CFO |
| C-01 | No additional headcount available | External help required for migration | IT Manager |

---

## 16. Recommendations arising from this assessment

Separate these into two lists, because it matters:

**Actions required regardless of the cloud decision:**
1. Test a restore from tape within 30 days
2. Place ClinicSchedule source code under version control
3. Remediate the reporting replica access list
4. Fix the Whitby domain controller replication
5. Add failure alerting to the OHIP billing batch

**Actions dependent on the cloud decision:** _(see the business case)_

_(Recommending things that do not depend on your own proposal is a strong credibility
signal. Do it deliberately.)_

---

## 17. Appendices

- **Appendix A** — Current state architecture diagram (`diagrams/current-state.png`)
- **Appendix B** — Interview notes
- **Appendix C** — Server room photographs and observations
- **Appendix D** — Cost source documents

---

## Revision history

| Version | Date | Author | Change |
|---|---|---|---|
| 1.0 | _( )_ | _( )_ | Initial assessment |
