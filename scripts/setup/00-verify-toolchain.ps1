<#
.SYNOPSIS
    Verifies the Week 1 local toolchain is installed and reports versions.

.DESCRIPTION
    Run this after installing the tools in Week 1 Part B. Every check should pass.
    Copy the version table it prints into docs/azure-account-baseline.md.

    If a tool reports "NOT FOUND" but you know you installed it, close the terminal
    completely and open a new one so the PATH refreshes. If it still fails, reboot.

.EXAMPLE
    .\00-verify-toolchain.ps1
#>

$ErrorActionPreference = 'SilentlyContinue'

function Test-Tool {
    param(
        [string]$Name,
        [string]$Command,
        [string]$VersionArgs
    )

    $exists = Get-Command $Command -ErrorAction SilentlyContinue
    if (-not $exists) {
        return [PSCustomObject]@{ Tool = $Name; Status = 'NOT FOUND'; Version = '-' }
    }

    $raw = & $Command $VersionArgs.Split(' ') 2>&1 | Select-Object -First 1
    return [PSCustomObject]@{ Tool = $Name; Status = 'OK'; Version = ($raw -replace '\s+', ' ').Trim() }
}

Write-Host "`nNorthgate Health Partners - Week 1 toolchain verification" -ForegroundColor Cyan
Write-Host ("-" * 70)

$results = @(
    Test-Tool -Name 'Git'                -Command 'git'  -VersionArgs '--version'
    Test-Tool -Name 'Visual Studio Code' -Command 'code' -VersionArgs '--version'
    Test-Tool -Name 'Azure CLI'          -Command 'az'   -VersionArgs 'version'
    Test-Tool -Name 'PowerShell 7'       -Command 'pwsh' -VersionArgs '--version'
    Test-Tool -Name 'GitHub CLI'         -Command 'gh'   -VersionArgs '--version'
)

# Az PowerShell module is checked differently - it is a module, not an executable
$azModule = Get-Module -ListAvailable Az.Accounts | Sort-Object Version -Descending | Select-Object -First 1
$results += [PSCustomObject]@{
    Tool    = 'Az PowerShell module'
    Status  = if ($azModule) { 'OK' } else { 'NOT FOUND' }
    Version = if ($azModule) { $azModule.Version.ToString() } else { '-' }
}

$results | Format-Table -AutoSize

Write-Host ("-" * 70)

$failed = $results | Where-Object { $_.Status -ne 'OK' }
if ($failed) {
    Write-Host "$($failed.Count) tool(s) missing. Close and reopen your terminal, then re-run." -ForegroundColor Yellow
} else {
    Write-Host "All tools present. Copy the table above into docs/azure-account-baseline.md." -ForegroundColor Green
}

# --- Azure sign-in check -----------------------------------------------------
Write-Host "`nAzure CLI sign-in status:" -ForegroundColor Cyan
$account = az account show --output json 2>$null | ConvertFrom-Json
if ($account) {
    Write-Host "  Signed in as : $($account.user.name)"
    Write-Host "  Subscription : $($account.name)"
    Write-Host "  Sub ID       : $($account.id)"
    Write-Host "  Tenant ID    : $($account.tenantId)"
    Write-Host "`n  Record the subscription and tenant IDs in docs/azure-account-baseline.md." -ForegroundColor Green
} else {
    Write-Host "  Not signed in. Run: az login" -ForegroundColor Yellow
}

Write-Host ""
