param(
    [Parameter(Mandatory = $true)]
    [string]$Version
)

$ErrorActionPreference = "Stop"

if ($Version -notmatch '^[0-9]+\.[0-9]+\.[0-9]+$') {
    throw "Version format must be semver like 0.1.1"
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
Set-Location -LiteralPath $repoRoot

Set-Content -LiteralPath "VERSION" -Value "$Version`n" -Encoding utf8

Write-Host "VERSION updated to $Version"
