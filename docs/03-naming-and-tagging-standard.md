# Naming and Tagging Standard

| | |
|---|---|
| **Document ID** | NHP-STD-003 |
| **Version** | 1.0 |
| **Date** | _(fill in)_ |
| **Author** | _(your name)_, Technology Analyst |
| **Status** | Draft / Approved |
| **Owner** | IT Manager |
| **Review cycle** | Annually, or on significant architecture change |

---

## 1. Purpose

This standard defines how Azure resources at Northgate Health Partners are named and
tagged. It exists because three things are effectively impossible to fix after the fact:

1. **Most Azure resources cannot be renamed.** Correcting a name means deleting and
   recreating the resource, which for stateful resources means an outage and a data migration.
2. **Cost allocation depends entirely on tags.** Answering "what is the scheduling
   application costing us per month" is only possible if every resource carries an
   `Application` tag from the day it is created. Cost data cannot be retrospectively tagged.
3. **Security decisions depend on classification.** A resource that does not declare
   whether it holds personal health information cannot be governed by policy.

## 2. Scope

Applies to all Azure resources in all Northgate subscriptions, and to all management
groups and resource groups.

Out of scope: on-premises servers (governed by the existing AD naming convention),
and resources inside SaaS platforms Northgate does not control.

---

## 3. Naming convention

### 3.1 Pattern

```
<resource-type>-<workload>-<environment>-<region>-<instance>
```

Lowercase throughout. Hyphen-separated, except where the resource type forbids hyphens
(see section 3.5).

| Component | Meaning | Example |
|---|---|---|
| `resource-type` | Abbreviation from the table in 3.2 | `rg`, `vnet`, `vm` |
| `workload` | The application or platform function | `clinicschedule`, `hub`, `platform` |
| `environment` | Deployment environment | `prod`, `nonprod`, `dev`, `sandbox` |
| `region` | Region abbreviation from 3.3 | `cc`, `ce` |
| `instance` | Two-digit sequence | `01`, `02` |

### 3.2 Resource type abbreviations

Aligned with the Microsoft Cloud Adoption Framework abbreviation guidance.

| Resource | Abbreviation | Example |
|---|---|---|
| Management group | `mg` | `mg-northgate-prod` |
| Resource group | `rg` | `rg-clinicschedule-prod-cc-01` |
| Virtual network | `vnet` | `vnet-hub-prod-cc-01` |
| Subnet | `snet` | `snet-web-prod-cc-01` |
| Network security group | `nsg` | `nsg-web-prod-cc-01` |
| Application security group | `asg` | `asg-web-prod-cc-01` |
| Public IP address | `pip` | `pip-appgw-prod-cc-01` |
| Network interface | `nic` | `nic-cssweb-prod-cc-01` |
| Load balancer (internal) | `lbi` | `lbi-clinicschedule-prod-cc-01` |
| Application gateway | `agw` | `agw-clinicschedule-prod-cc-01` |
| VPN gateway | `vgw` | `vgw-hub-prod-cc-01` |
| Private endpoint | `pep` | `pep-sqlclinicschedule-prod-cc-01` |
| Private DNS zone | `pdnsz` | `pdnsz-privatelink-database-windows-net` |
| Virtual machine | `vm` | `vm-cssweb-prod-cc-01` |
| VM scale set | `vmss` | `vmss-cssweb-prod-cc-01` |
| Managed disk (OS) | `osdisk` | `osdisk-cssweb-prod-cc-01` |
| Managed disk (data) | `datadisk` | `datadisk-cssweb-prod-cc-01` |
| App Service plan | `asp` | `asp-clinicschedule-prod-cc-01` |
| App Service / Web App | `app` | `app-clinicschedule-prod-cc-01` |
| Function app | `func` | `func-labparser-prod-cc-01` |
| Logic app | `logic` | `logic-labresults-prod-cc-01` |
| Service Bus namespace | `sbns` | `sbns-integration-prod-cc-01` |
| Service Bus queue | `sbq` | `sbq-labresults-prod-cc-01` |
| Event Grid topic | `evgt` | `evgt-fileingest-prod-cc-01` |
| Azure SQL server | `sql` | `sql-northgate-prod-cc-01` |
| Azure SQL database | `sqldb` | `sqldb-clinicschedule-prod-cc-01` |
| Storage account | `st` | `stnhpdocsprodcc01` (no hyphens) |
| Key Vault | `kv` | `kv-northgate-prod-cc-01` |
| Log Analytics workspace | `log` | `log-northgate-prod-cc-01` |
| Application Insights | `appi` | `appi-clinicschedule-prod-cc-01` |
| Recovery Services vault | `rsv` | `rsv-northgate-prod-cc-01` |
| Automation account | `aa` | `aa-northgate-prod-cc-01` |
| Managed identity | `id` | `id-labparser-prod-cc-01` |

### 3.3 Region abbreviations

| Region | Abbreviation |
|---|---|
| Canada Central (Toronto) | `cc` |
| Canada East (Quebec City) | `ce` |

### 3.4 Environment values

| Value | Meaning |
|---|---|
| `prod` | Production. Serves patients or staff. Change-controlled. |
| `nonprod` | Pre-production, UAT, staging. Mirrors production configuration. |
| `dev` | Development. May be unstable. |
| `sandbox` | Throwaway. **Subject to automated deletion.** Never holds real data. |

### 3.5 Constraints that override the pattern

Azure enforces different rules by resource type. Where a rule conflicts with the pattern,
the rule wins. The most important:

| Resource | Length | Allowed characters | Uniqueness scope |
|---|---|---|---|
| **Storage account** | 3-24 | lowercase letters and digits only — **no hyphens** | **Global** |
| **Key Vault** | 3-24 | alphanumerics and hyphens, must start with a letter | **Global** |
| **Virtual machine (Windows)** | 1-15 | alphanumerics and hyphens | Resource group |
| **Virtual machine (Linux)** | 1-64 | alphanumerics and hyphens | Resource group |
| **Resource group** | 1-90 | alphanumerics, hyphens, underscores, periods, parentheses | Subscription |
| **Virtual network** | 2-64 | alphanumerics, hyphens, underscores, periods | Resource group |
| **SQL server** | 1-63 | lowercase alphanumerics and hyphens | **Global** |

**Globally unique** means unique across every Azure customer worldwide, because the
resource is issued a public DNS name. Expect to need a discriminator.

**Storage account convention** (no hyphens available):
```
st<org><workload><environment><region><instance>
stnhpdocsprodcc01
stnhplogsprodcc01
```

**Windows VM 15-character limit** forces abbreviation of the workload:
```
vm-cssweb-p-cc01     (clinicschedule web, prod, canada central, 01)
```
Document the abbreviation in the resource's `Application` tag so the full name is
still discoverable.

---

## 4. Tagging standard

### 4.1 Mandatory tags

Every resource and every resource group carries all eight.

| Tag | Allowed values | Purpose |
|---|---|---|
| `Environment` | `prod` · `nonprod` · `dev` · `sandbox` | Policy targeting, cost split, change control scope |
| `Application` | `clinicschedule` · `fileservices` · `integration` · `billing` · `platform` | **Cost allocation.** The tag the CFO's reporting depends on. |
| `Owner` | A valid email address | Who is accountable and who gets called |
| `CostCentre` | `IT-001` · `CLIN-004` · `ADMIN-002` | Chargeback and showback |
| `DataClassification` | `public` · `internal` · `confidential` · `phi` | **Drives every security control decision.** |
| `Criticality` | `tier1` · `tier2` · `tier3` | Drives availability, backup and monitoring requirements |
| `ManagedBy` | `bicep` · `manual` | Drift detection from Week 8 onward |
| `CreatedDate` | ISO 8601 date, e.g. `2026-08-25` | Housekeeping and orphan identification |

### 4.2 Conditional tags

| Tag | Required when | Purpose |
|---|---|---|
| `DeleteAfter` | `Environment` is `sandbox` or `dev` | ISO date. Automated cleanup deletes past this date. **Added as a result of INC-001.** |
| `ExceptionRef` | The resource exists under a documented policy exception | Links to the exception register entry |
| `RetentionYears` | `DataClassification` is `phi` | Records retention period |

### 4.3 Classification definitions

| Value | Definition | Baseline controls |
|---|---|---|
| `public` | Intended for public release | Standard |
| `internal` | Internal business information; disclosure is embarrassing, not harmful | Access limited to staff; encryption at rest |
| `confidential` | Commercially or personally sensitive; disclosure causes harm | Least privilege; encryption in transit and at rest; audit logging |
| `phi` | Personal health information under PHIPA | All of the above, plus private network access only, audit logging retained, immutable retention where records are involved, breach response procedure applies |

### 4.4 Tags do not inherit

**A tag applied to a resource group does not appear on the resources inside it.**
This is a genuine and frequently misunderstood behaviour of Azure.

Tags must be applied at resource creation. From Week 10, the Azure Policy built-in
definition *"Inherit a tag from the resource group"* (Modify effect) is assigned to
enforce inheritance automatically, with a remediation task for existing resources.

---

## 5. Enforcement

| Phase | Mechanism | Status |
|---|---|---|
| Week 1-9 | Convention, applied manually and reviewed at commit | Current |
| Week 8 | Bicep templates parameterize naming, making violation harder than compliance | Planned |
| Week 10 | Azure Policy — `Require a tag on resources` (Deny) for the eight mandatory tags; `Allowed values` for the constrained tags; `Inherit a tag from the resource group` (Modify) | Planned |
| Week 10 | A compliance report is produced monthly and non-compliant resources are remediated or exception-registered | Planned |

**Governance rollout principle:** policies are assigned in **Audit** mode first, the
impact is reviewed and communicated, and only then are they switched to **Deny**. Moving
straight to Deny is how governance initiatives get reversed by frustrated colleagues.

## 6. Exceptions

Any deviation requires an entry in `docs/exception-register.md` recording: the resource,
the rule deviated from, the business reason, the compensating control, the approver, and
a review date. Exceptions are time-bound by default.

## 7. Review

This standard is reviewed annually and whenever a new resource type is introduced that
has no abbreviation defined.

---

## Revision history

| Version | Date | Author | Change |
|---|---|---|---|
| 1.0 | _(fill in)_ | _(your name)_ | Initial standard |
| 1.1 | _(fill in)_ | _(your name)_ | Added `DeleteAfter` conditional tag following INC-001 |
