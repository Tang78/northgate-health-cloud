# INC-001: Unexpected subscription spend triggering budget alert

> **TEMPLATE — Week 1.** Fill this in as you investigate, not afterwards. The value of
> the exercise is in writing the timeline **while** you are working, including the steps
> that led nowhere.

| | |
|---|---|
| **Incident ID** | INC-001 |
| **Severity** | Sev 4 (financial, no service impact) |
| **Status** | _( )_ |
| **Detected** | _(date/time)_ — budget alert `budget-tripwire-daily`, forecast exceeded 100% |
| **Mitigated** | |
| **Resolved** | |
| **Time to detect (MTTD)** | _(from first chargeable usage to alert — note that this is bounded below by the Azure cost data lag)_ |
| **Time to resolve (MTTR)** | |
| **Systems affected** | None — no service impact |
| **Data affected** | None. No PHI involved. |
| **Author** | _(your name)_ |

---

## 1. Summary

_(Two or three sentences. What alerted, what was found, what the actual cost was, and
what the projected cost would have been if it had gone unnoticed.)_

## 2. Impact

| Dimension | Impact |
|---|---|
| Actual cost incurred | CAD $_( )_ |
| Projected monthly cost if undetected | CAD $_( )_ |
| Percentage of remaining credit | _( )_% |
| Service impact | None |
| Clinical impact | None |
| Privacy impact | None |

## 3. Timeline

_(Fill in as you go. Include the steps that did not narrow things down.)_

| Time | Event |
|---|---|
| _(date) 21:40_ | Budget alert email received for `budget-tripwire-daily` — forecast exceeded 100% of CAD $5 |
| | Opened Cost Management → Cost Analysis. Set granularity to Daily. |
| | Established that spend began on _( )_ |
| | Grouped by Resource group. Result: _( )_ |
| | Grouped by Service name. Result: _( )_ |
| | Grouped by Meter. Result: _( )_ |
| | Grouped by Resource. Identified: _( )_ |
| | Checked forecast. Projected month total: _( )_ |
| | Checked Azure Advisor cost recommendations. Result: _( )_ |
| | Confirmed findings against the resource list |
| | Deleted `rg-sandbox-cc-01` and recreated it |
| | Confirmed spend ceased _(note: confirmation is delayed by the cost data lag)_ |

## 4. Investigation

_(Describe the diagnostic reasoning. Why did you group by meter rather than by resource
first? What did each grouping tell you that the previous one did not? Note that in a real
subscription with hundreds of resources, scanning the resource list is not a viable
approach, which is why Cost Analysis grouping is the correct method.)_

### Cost Analysis findings

| Grouping | What it revealed |
|---|---|
| Resource group | |
| Service name | |
| Meter | |
| Resource | |

### Resources identified

| Resource | Type | Meter | Daily cost | Why it was costing money |
|---|---|---|---|---|
| | Public IP (Standard) | | | Standard public IPs are billed whether or not they are attached to anything |
| | Managed disk | | | Managed disks are billed on **provisioned** size, not used size, and are billed whether or not attached to a VM |
| | Storage account | | | Redundancy tier affects price — GZRS costs materially more than LRS |
| | Managed disk | | | |

## 5. Root cause

**Technical cause.** _( )_

**Why was that possible?** _( )_

**Why was it not caught sooner?** _(The Azure cost data lag of approximately 8-24 hours
places a floor on how quickly any cost-based detective control can fire.)_

**Why was it not prevented?** _( )_

**Systemic cause.** _(The real answer is not "I created some resources." It is that
resources were created for a one-off test with no owner, no expiry, no cleanup step, and
no preventive control restricting what could be created.)_

## 6. Contributing factors

- No Azure Policy restricting allowed SKUs or resource types
- No mandatory expiry tag on sandbox resources
- No automated cleanup of the sandbox resource group
- Cost data lag of 8-24 hours delays all cost-based detection
- Azure Advisor flags unattached disks but nobody had a routine of reading it

## 7. What went well

- The tripwire budget fired, and it fired on **forecast** rather than actuals, giving
  earlier warning than an actual-spend threshold would have
- Cost Analysis grouping by meter identified the specific charge types quickly
- Total exposure was trivial because the budget threshold was set deliberately low

## 8. What went badly

- _( )_

## 9. Resolution

_(What you deleted, when, and how you confirmed spend stopped. Note the deletion method —
deleting the resource group rather than individual resources is faster and less error-prone.)_

```powershell
az group delete --name "rg-sandbox-cc-01" --yes --no-wait
```

## 10. Modelling exercise — what this would have cost at real scale

The resources found were trivially cheap. The exercise is what the same failure mode
costs when the resource is expensive.

**Scenario.** A colleague deploys an Azure Bastion host on the Friday of a long weekend
to troubleshoot a VM and forgets to delete it. The same budget alerts are in place. Given
the 8-24 hour cost data lag and no weekend review, when is it detected and what has it cost?

| | |
|---|---|
| Bastion Basic hourly cost (CAD, Canada Central) | _( )_ |
| Cost per day | _( )_ |
| Cost over a 3-day long weekend | _( )_ |
| Detected on | _( )_ |
| Percentage of the free account credit | _( )_% |

**Scaled to a production subscription.** _(Repeat for Azure Firewall at roughly $30/day.
Then consider what happens in an organisation where nobody has a daily cost review — the
answer is that it runs until the quarterly finance review, which is a real thing that
really happens and is the reason FinOps exists as a discipline.)_

## 11. Lessons learned

1. **Budgets alert; they do not prevent.** There is no hard spending cap on a
   Pay-As-You-Go subscription. Detection is not a control.
2. **Cost data lags 8-24 hours**, which places a hard floor on how fast any cost-based
   detective control can respond. This is the argument for preventive controls.
3. **Preventive controls are what actually work**: Azure Policy on allowed SKUs, resource
   types and regions; subscription quotas; mandatory tagging including an expiry date; and
   automated cleanup of ephemeral resource groups.
4. **Unattached managed disks and unassociated public IPs are the classic silent costs.**
   Azure Advisor identifies both for free, and nobody reads Azure Advisor.
5. **Managed disks bill on provisioned size, not used size**, and continue billing after
   the VM they belonged to is deleted.
6. _( )_

## 12. Action items

| # | Action | Type | Owner | Due | Status |
|---|---|---|---|---|---|
| 1 | Add a mandatory `DeleteAfter` tag to the naming and tagging standard for all sandbox and dev resources | Preventive | _(you)_ | Week 1 | **Done** |
| 2 | Add a daily Cost Analysis review to the personal operating routine | Detective | _(you)_ | Week 1 | **Done** |
| 3 | Implement Azure Policy restricting allowed VM SKUs, disk SKUs and regions | Preventive | _(you)_ | Week 10 | Open |
| 4 | Build an Azure Automation runbook to delete the contents of `rg-sandbox-*` weekly | Preventive | _(you)_ | Week 8 | Open |
| 5 | Add a weekly orphaned-resource report (unattached disks, unassociated public IPs, empty App Service plans) to the operational rhythm | Detective | _(you)_ | Week 9 | Open |

> Three of these five actions are deliberately scheduled into later weeks. This creates a
> traceable thread across the project: an action raised in Week 1 and closed in Week 10 is
> exactly what long-running real projects look like, and it is worth being able to point at.

## 13. Blameless statement

This review is blameless. The cause was an absence of preventive controls and an absent
cleanup process, not an individual's error.

## 14. Appendices

- `cost-analysis-by-meter.png`
- `cost-analysis-by-resource.png`
- `budget-alert-email.png`
- `bastion-pricing-model.xlsx`
