# Lab Cost Guardrails

> Consult this before deploying anything unfamiliar. Fill in the real figures from the
> Azure pricing calculator (currency CAD, region Canada Central) rather than trusting
> the placeholder estimates.

**Region:** Canada Central · **Currency:** CAD · **Prices verified:** _(date)_

---

## 1. The four credit killers

Deploy these deliberately, capture evidence, and delete them the same session. Set a
phone timer before you deploy.

| Service | SKU | Per hour | Per day | Per 30 days | Max lab duration | % of a $260 credit per day |
|---|---|---|---|---|---|---|
| Azure Firewall | Standard | _( )_ | _( )_ | _( )_ | **1 hour** | _( )_ |
| Azure Bastion | Basic | _( )_ | _( )_ | _( )_ | 2 hours | _( )_ |
| VPN Gateway | VpnGw1 | _( )_ | _( )_ | _( )_ | 3 hours | _( )_ |
| Application Gateway | Standard_v2 | _( )_ | _( )_ | _( )_ | 2 hours | _( )_ |

## 2. Moderate cost — watch these

| Service | SKU | Per hour | Per 30 days | Notes |
|---|---|---|---|---|
| Virtual machine | B2ms Windows | | | Windows licence is embedded in the price |
| Virtual machine | B2s Linux | | | Materially cheaper — no OS licence |
| Virtual machine | B1s Linux/Windows | | | **Free tier: 750 hrs/month for 12 months** |
| Azure SQL Database | General Purpose 2 vCore | | | |
| Azure SQL Database | Basic / Serverless | | | Check the current free offer |
| Managed disk | Premium SSD P10 (128 GB) | | | Billed on provisioned size |
| Managed disk | Standard SSD E10 (128 GB) | | | |
| Public IP | Standard static | | | **Billed whether attached or not** |
| Log Analytics | Per GB ingested | | | Chatty diagnostic settings add up fast |
| Recovery Services vault | Per protected instance + storage | | | |
| Azure Site Recovery | Per protected instance | | | Plus egress for replication |
| Load Balancer | Standard | | | Basic tier is being retired |
| Microsoft Sentinel | Per GB analysed | | | Expensive. Trial only. |
| Microsoft Purview | Per capacity unit + scan | | | Check the free tier |

## 3. Effectively free at lab scale

| Service | Note |
|---|---|
| Resource groups | No charge |
| Management groups | No charge |
| Virtual networks, subnets, NSGs, ASGs | No charge for the objects themselves |
| VNet peering | Charged per GB transferred, negligible at lab scale |
| Microsoft Entra ID Free tier | No charge |
| Azure Policy | No charge |
| Azure Advisor | No charge |
| Service Health | No charge |
| Resource Graph | No charge |
| Cost Management | No charge |
| Azure Monitor metrics | Platform metrics free; log ingestion is not |
| Logic Apps Consumption | Generous free grant, then per action |
| Azure Functions Consumption | 1M executions free per month |
| App Service F1 | Free tier, limited |
| Key Vault | Fractions of a cent per operation |
| Blob storage | Pennies at lab volumes |

## 4. The silent costs

These accumulate without any visible resource doing anything.

| Cost | Why it happens | How to find it |
|---|---|---|
| Unattached managed disks | Left behind when a VM is deleted without its disks | Azure Advisor → Cost; `az disk list --query "[?diskState=='Unattached']"` |
| Unassociated public IPs | Standard SKU IPs bill whether attached or not | Azure Advisor → Cost |
| Empty App Service plans | The plan bills even with no app on it | Resource Graph query |
| Old snapshots | Never expire on their own | `az snapshot list` |
| Log Analytics ingestion | An over-enthusiastic diagnostic setting | Cost Analysis grouped by meter |
| Cross-region egress | Replication, backup to a paired region, VNet peering across regions | Cost Analysis grouped by meter |
| Recovery Services vault storage | Backups accumulate under a long retention policy | Vault → Backup Jobs and usage |

## 5. Pre-deployment checklist

Before deploying anything you have not deployed before:

- [ ] Priced it in the pricing calculator, in CAD, in Canada Central
- [ ] Checked whether a free or cheaper tier meets the learning objective
- [ ] Set a timer if it is in the credit-killer table
- [ ] Applied all mandatory tags including `DeleteAfter` if it is sandbox or dev
- [ ] Configured auto-shutdown if it is a VM, **at creation time**
- [ ] Know the exact command that deletes it, before creating it

## 6. Post-session checklist

- [ ] `az resource list --output table` — is anything running that should not be?
- [ ] Any VM either deallocated or deleted (deallocated, not "shut down from inside Windows")
- [ ] Sandbox resource group deleted if the work is finished
- [ ] Cost Analysis checked (remember the 8-24 hour lag — today's spend may not show yet)
- [ ] Credit remaining recorded in `docs/azure-account-baseline.md`

## 7. The teardown command

The fastest and most reliable cleanup is deleting the resource group, not the individual
resources.

```powershell
az group delete --name "rg-sandbox-cc-01" --yes --no-wait
az group create --name "rg-sandbox-cc-01" --location canadacentral `
  --tags Environment=sandbox Application=platform Owner="you@example.com" `
         CostCentre=IT-001 DataClassification=internal Criticality=tier3 ManagedBy=manual
```

From Week 8, the entire environment is defined in Bicep and this becomes the normal
weekly rhythm rather than an emergency measure.
