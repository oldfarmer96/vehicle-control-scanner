$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
Set-Location -LiteralPath $repoRoot

$nsisCandidates = @(
    "${env:ProgramFiles(x86)}\NSIS\makensis.exe",
    "${env:ProgramFiles}\NSIS\makensis.exe"
)

$nsis = $nsisCandidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
if (-not $nsis) {
    throw "NSIS not found. Install NSIS and ensure makensis.exe is available."
}

& $nsis "installer/vehicle-control-scanner.nsi"
