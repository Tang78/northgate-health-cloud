# ADR-0002: Azure region selection

> **TEMPLATE.** The context and structure are provided. Fill in the analysis, do your
> own verification, and write the consequences section yourself — that is the part that
> demonstrates thinking.

| | |
|---|---|
| **Status** | Proposed → _(change to Accepted when done)_ |
| **Date** | _(fill in)_ |
| **Deciders** | _(your name)_, Technology Analyst |
| **Consulted** | Sandra Lee (Privacy Officer), Priya Raman (IT Manager) |
| **Supersedes** | — |
| **Superseded by** | — |

---

## Context

Northgate Health Partners is a **health information custodian** under Ontario's *Personal
Health Information Protection Act, 2004* (PHIPA), holding personal health information for
approximately 120,000 patients. All workloads under consideration — patient scheduling,
clinical document storage, lab result integration and OHIP billing — process or store PHI.

Users are concentrated in Durham Region, Ontario, across six clinic sites and one head office.

A primary Azure region must be selected before any resource is deployed, because region
is fixed at creation for most resource types and changing it means redeploying. A paired
secondary region must also be identified for the disaster recovery design in a later phase.

### The data residency position — state this precisely

PHIPA does not contain a blanket statutory prohibition on storing personal health
information outside Ontario or outside Canada. What it requires is that a health
information custodian take **reasonable steps** to protect PHI against theft, loss and
unauthorized use or disclosure, and that the custodian remains accountable for it
regardless of who holds it.

In practice, Ontario health organizations commonly adopt Canadian data residency as a
matter of **internal policy, contractual obligation and risk appetite**, driven by
guidance from the Information and Privacy Commissioner of Ontario, agreements with
Ontario Health, patient and clinician expectations, and a desire to avoid arguments about
foreign government access to data.

Northgate's position: _(state whether Canadian residency is required by internal policy,
by a specific clause in a data sharing agreement, or both. Note the action item for the
Privacy Officer to confirm the specific contractual obligations, because that is what
you would actually do rather than assuming.)_

**Being precise about this distinction — policy requirement rather than statutory
prohibition — matters. It is the difference between a document that reads as professional
and one that reads as repeating something half-heard.**

## Decision drivers

1. **Data residency** — Canadian residency required by policy and contract
2. **Latency** — user concentration in Durham Region
3. **Service availability** — not every Azure service exists in every region
4. **Availability zone support** — determines the resilience options available
5. **Region pairing** — required for geo-redundant storage and DR design
6. **Cost** — regional price variation
7. **DR capability** — the secondary region's characteristics constrain the DR design

## Options considered

### Option 1 — Canada Central (Toronto) primary, Canada East (Quebec City) secondary

**Description.** _( )_

**Data residency.** _( )_

**Latency from Durham Region.** _(Measure it. Use `psping`, an online latency tool, or
deploy a VM briefly and test. Record the actual number and your method rather than
citing a guess.)_

**Availability zones.** _(Verify current status and record the date you checked.)_

**Service availability.** _(Check the "Products available by region" page for the services
in your target architecture. Note any that are missing from either region.)_

**Cost.** _(Compare a representative SKU across the candidate regions using the pricing
calculator in CAD.)_

**Assessment.** _( )_

### Option 2 — Canada East primary, Canada Central secondary

**Description.** _( )_

**Assessment.** _(Consider: why would you not put primary in the region with fewer
services and no availability zones? Say it explicitly.)_

### Option 3 — A United States region such as East US 2

**Description.** _( )_

**Assessment.** _(Consider residency, cost difference, latency, service breadth, and
whether the marginal benefit is worth the residency argument with the Privacy Officer.
The interesting conclusion here is that there is no meaningful trade-off to accept —
the cost and latency differences are small enough that residency wins without a fight.
Say that; a decision where the trade-off turns out to be negligible is worth documenting
precisely because it stops the question being reopened.)_

### Option 4 — Multi-region active-active across both Canadian regions

**Description.** _( )_

**Assessment.** _(Consider cost, complexity, and whether the business availability
requirement — 99.9% during clinic hours for a six-clinic group — justifies it. It almost
certainly does not, and explaining why you rejected the most resilient option on
cost-benefit grounds is a strong signal of judgement.)_

### Comparison

| Criterion | Canada Central | Canada East | East US 2 | Multi-region |
|---|---|---|---|---|
| Canadian residency | | | | |
| Availability zones | | | | |
| Service breadth | | | | |
| Latency from Durham | | | | |
| Relative cost | | | | |
| Complexity | | | | |

## Decision

> We will deploy all production workloads to **Canada Central** as the primary region,
> with **Canada East** as the paired secondary region for geo-redundant storage and
> disaster recovery.

_(Then a paragraph of reasoning tied back to the decision drivers.)_

## Consequences

### Positive

- _( )_

### Negative

> **Write these honestly. This is the section that shows you understand what you chose.**

- **The DR region has no availability zones.** _(Explain what this means: resilience in a
  failover scenario is structurally weaker than in production. Zone-redundant configurations
  available in Canada Central cannot be replicated in Canada East. This must be reflected
  in the RTO and RPO commitments for a failover scenario rather than assumed away.)_
- **Canada East has a narrower service catalogue.** _(Explain the implication: every service
  in the target architecture must be verified as available in Canada East before the DR
  design commits to it. Do not assume symmetry between paired regions.)_
- **Canadian region pricing.** _( )_
- **Two regions only.** _(Unlike the US or Europe, there is no third Canadian region to
  fall back to. If both Canadian regions are unavailable, the only options are accepting
  the outage or breaking the residency requirement under a documented emergency provision.
  Note whether such a provision exists.)_

### Neutral / follow-on work

- Action: re-verify Canada East service availability for every service in the DR design
  before the disaster recovery architecture is finalised (Phase 5 / Week 11)
- Action: Privacy Officer to confirm the specific contractual data residency obligations
  in the Ontario Health and lab partner agreements

## Conditions for revisiting

_(What would change this? A third Canadian region. Availability zone support arriving in
Canada East. A contractual change permitting US storage. A service critical to the
architecture never becoming available in Canada.)_

## Verification

| What I checked | Source | Date checked |
|---|---|---|
| Availability zone support by region | _(Microsoft Learn — Azure regions with availability zone support)_ | _( )_ |
| Region pairing | _(Microsoft Learn — Azure cross-region replication pairings)_ | _( )_ |
| Service availability | _(Azure — Products available by region)_ | _( )_ |
| Pricing comparison | _(Azure pricing calculator, CAD)_ | _( )_ |
| Latency | _(your own measurement — state the method)_ | _( )_ |

> Recording what you checked and when is a habit worth forming. Cloud documentation
> changes, and an undated claim is a claim with an unknown expiry date.

## References

-
