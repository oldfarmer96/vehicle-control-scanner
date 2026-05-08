param(
    [string]$CondaEnv = "scanner-ocr"
)

$ErrorActionPreference = "Stop"

Write-Host "[1/4] Verifying project files..."
if (-not (Test-Path -LiteralPath "environment.yml")) {
    throw "environment.yml not found"
}
if (-not (Test-Path -LiteralPath "installer/vehicle-control-scanner.spec")) {
    throw "PyInstaller spec not found"
}

Write-Host "[2/4] Installing build dependencies in conda env..."
conda run -n $CondaEnv python -m pip install -r requirements.txt -r requirements-build.txt

Write-Host "[3/4] Building executable with PyInstaller..."
conda run -n $CondaEnv pyinstaller --noconfirm --clean installer/vehicle-control-scanner.spec

Write-Host "[4/4] Build complete"
Write-Host "Output folder: dist/"
