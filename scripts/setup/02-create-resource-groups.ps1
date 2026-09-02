<#
.SYNOPSIS
    Creates the Northgate resource group structure with mandatory tags.

.DESCRIPTION
    Week 1, Task D5.

    Resource groups are free. The structure below follows the lifecycle test:
    resources in a group should share a lifecycle, so that deleting the group
    is a sensible operation rather than a catastrophe.

    Note the platform / workload split. Platform resource groups hold long-lived
    shared infrastructure that changes rarely. Workload resource groups are tied
    to an application and can be destroyed and rebuilt without touching the
    network or the monitoring.

.NOTES
    Edit $Owner before running.
    Tags do NOT inherit to the resources inside these groups - that is enforced
    with Azure Policy in Week 10.
#>

param(
    [string]$Location = "canadacentral",
    [string]$Owner    = "you@example.com"
)

$created = (Get-Date -Format "yyyy-MM-dd")

# Resource group definitions: name, application, classification, criticality, cost centre
$resourceGroups = @(
    @{ Name = "rg-platform-network-prod-cc-01";    App = "platform";       Class = "internal";     Tier = "tier1"; CC = "IT-001";   Env = "prod"    }
    @{ Name = "rg-platform-monitoring-prod-cc-01"; App = "platform";       Class = "internal";     Tier = "tier1"; CC = "IT-001";   Env = "prod"    }
    @{ Name = "rg-platform-security-prod-cc-01";   App = "platform";       Class = "confidential"; Tier = "tier1"; CC = "IT-001";   Env = "prod"    }
    @{ Name = "rg-clinicschedule-prod-cc-01";      App = "clinicschedule"; Class = "phi";          Tier = "tier1"; CC = "CLIN-004"; Env = "prod"    }
    @{ Name = "rg-fileservices-prod-cc-01";        App = "fileservices";   Class = "phi";          Tier = "tier2"; CC = "IT-001";   Env = "prod"    }
    @{ Name = "rg-integration-prod-cc-01";         App = "integration";    Class = "phi";          Tier = "tier1"; CC = "IT-001";   Env = "prod"    }
    @{ Name = "rg-sandbox-cc-01";                  App = "platform";       Class = "internal";     Tier = "tier3"; CC = "IT-001";   Env = "sandbox" }
)

foreach ($rg in $resourceGroups) {

    $tags = @(
        "Environment=$($rg.Env)"
        "Application=$($rg.App)"
        "Owner=$Owner"
        "CostCentre=$($rg.CC)"
        "DataClassification=$($rg.Class)"
        "Criticality=$($rg.Tier)"
        "ManagedBy=manual"
        "CreatedDate=$created"
    )

    # Sandbox resources get an expiry date - added as a result of INC-001
    if ($rg.Env -eq "sandbox") {
        $tags += "DeleteAfter=$((Get-Date).AddDays(7).ToString('yyyy-MM-dd'))"
    }

    Write-Host "Creating $($rg.Name)..." -ForegroundColor Cyan
    az group create --name $rg.Name --location $Location --tags $tags --output none
}

Write-Host "`nResource groups created:`n" -ForegroundColor Green
az group list --query "[].{Name:name, Location:location, App:tags.Application, Class:tags.DataClassification, Tier:tags.Criticality}" --output table

Write-Host "`nReminder: tags on a resource group do NOT inherit to resources inside it." -ForegroundColor Yellow
Write-Host "Enforcement via Azure Policy 'Inherit a tag from the resource group' is scheduled for Week 10.`n"
