# Azure Account Baseline

> Record this on signup day. Microsoft changes free account terms regularly, and the
> authoritative version is what appeared on your screen on your signup date — not what
> any article says. Recording the terms and your tool versions is a small professional
> habit that saves real time when something breaks in week six.

---




git --version- git version 2.53.0.windows.2
code --version- 1.116.0
560a9dba96f961efea7b1612916f89e5d5d4d679
x64
az version-{
  "azure-cli": "2.90.0",
  "azure-cli-core": "2.90.0",
  "azure-cli-telemetry": "1.1.0",
  "extensions": {}
}
pwsh --version-PowerShell 7.6.5
gh --version- gh version 2.98.0 (2026-08-20)
https://github.com/cli/cli/releases/tag/v2.98.0
Get-Module -ListAvailable Az.Accounts | Select-Object Name, Version -- Name        Version
----        -------
Az.Accounts 5.5.3


## 1. Account

| Item | Value |
|---|---|
| Signup date | _( )_ |
| Microsoft account | _(email)_ |
| Country/Region selected | Canada |
| Billing currency | CAD |
| Two-factor authentication enabled | Yes / No |
| Authenticator app registered | Yes / No |
| Recovery codes stored offline | Yes / No |

## 2. Identifiers

| Item | Value |
|---|---|
| Tenant ID | _( )_ |
| Tenant default domain | _( ).onmicrosoft.com_ |
| Subscription name | _( )_ |
| Subscription ID | _( )_ |
| Offer type | _(e.g. Free Trial / Pay-As-You-Go after conversion)_ |
| Support plan | Basic |
| Primary region | Canada Central |
| Paired secondary region | Canada East |

## 3. Free account entitlements as of signup date

> **The three entitlements have different expiry dates. This catches almost everyone.**

| Entitlement | Amount | Expires | Notes |
|---|---|---|---|
| **Credit** | CAD $_( )_ | _(signup + 30 days = date)_ | **30 days, not 12 months** |
| **12-month free services** | See below | _(signup + 12 months = date)_ | Monthly allowances, reset each month |
| **Always-free services** | See below | Never | Perpetual monthly allowances |

### 12-month free services (record what was actually listed)

| Service | Allowance |
|---|---|
| _( )_ | _( )_ |
| _( )_ | _( )_ |

### Always-free services relevant to this project

| Service | Allowance |
|---|---|
| _( )_ | _( )_ |

**Screenshots:** `diagrams/free-account-terms.png`

---

## 4. Credit burn plan

The credit expires 30 days after signup. Several genuinely expensive services appear
later in the project and will be unaffordable then. They are deliberately front-loaded
into the credit window: deployed, evidenced, and destroyed the same day.

| Service | Scheduled week | Plan to deploy by | Max lab duration | Actual date deployed | Deleted? |
|---|---|---|---|---|---|
| Azure Bastion | 2 | _(date)_ | 2 hours | | |
| VPN Gateway | 3 | _(date)_ | 3 hours | | |
| Application Gateway | 2-3 | _(date)_ | 2 hours | | |
| Azure Firewall | 10 | _(date)_ | **1 hour** | | |
| Premium SQL tier | 6 | _(date)_ | 2 hours | | |
| Azure Site Recovery | 11 | _(date)_ | 4 hours | | |

**Credit remaining:** update weekly.

| Week | Date | Credit remaining (CAD) | Month-to-date spend |
|---|---|---|---|
| 1 | | | |
| 2 | | | |
| 3 | | | |
| 4 | | | |

---

## 5. Cost guardrails configured

| Control | Configuration | Date set |
|---|---|---|
| `budget-northgate-monthly` | CAD $50/month, alerts at actual 50/75/90% and forecast 100% | |
| `budget-tripwire-daily` | CAD $5/month, alert at actual 100% | |
| Service Health alert | All regions, all services, service issues → email | |
| Daily Cost Analysis review | Personal reminder set for 21:00 | |

**Screenshot:** `diagrams/budget-configuration.png`

**Known limitation:** budgets alert but do not enforce. Azure will bill past a budget.
Preventive controls (Azure Policy on SKUs and regions, quotas, automated shutdown
triggered by the budget alert action group) are scheduled for Weeks 8 and 10 — see
INC-001 action items 3 and 4.

---

## 6. Baseline measurements

| Metric | Value | Date |
|---|---|---|
| Defender for Cloud Secure Score | _( )_% | |
| Number of resources | _( )_ | |
| Number of resource groups | 7 | |
| Azure Advisor recommendations | _( )_ | |

Re-measure Secure Score in Week 10 and record the improvement. A before-and-after
Secure Score is a compelling portfolio number.

---

## 7. Local toolchain

| Tool | Version | Install date |
|---|---|---|
| Git | | |
| Visual Studio Code | | |
| Azure CLI (`az`) | | |
| PowerShell (`pwsh`) | | |
| Az PowerShell module | | |
| GitHub CLI (`gh`) | | |
| draw.io Desktop | | |
| Windows Terminal | | |

**VS Code extensions installed:**
- ms-azuretools.vscode-azureresourcegroups
- ms-azuretools.vscode-bicep
- ms-vscode.azurecli
- ms-vscode.powershell
- yzhang.markdown-all-in-one
- DavidAnson.vscode-markdownlint
- bierner.markdown-mermaid
- hediet.vscode-drawio
- GitHub.vscode-pull-request-github
- streetsidesoftware.code-spell-checker

---

## 8. Known risks in this setup

| # | Risk | Why it exists | Planned remediation |
|---|---|---|---|
| 1 | A single account holds Global Administrator and subscription Owner with no break-glass account | Free account, single user | Documented as a deviation from good practice. Break-glass account and PIM covered in Week 4. |
| 2 | No separate non-production subscription | Free account limitation | Environment separation achieved by resource group and tagging instead. Documented in the resource hierarchy design. |
| 3 | No Azure Policy enforcement in place | Scheduled for Week 10 | Naming and tagging enforced by convention and review until then |

> Identifying the weaknesses in your own setup — and saying what you would do differently
> with a real budget — is worth more than pretending the lab is an enterprise environment.
