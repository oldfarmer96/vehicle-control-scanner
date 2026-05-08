# Windows Build and Installer Guide

This guide explains how to rebuild the executable and generate the NSIS installer.

## Prerequisites

- Miniconda/Conda installed.
- NSIS installed (`makensis` available).
- Conda environment name: `scanner-ocr`.

## One-time setup

```bash
conda create --name scanner-ocr python=3.12 -y
conda activate scanner-ocr
pip install -r requirements.txt -r requirements-build.txt
```

## Build executable

Option A (recommended):

```bash
make build-exe
```

Option B (direct command):

```bash
pwsh -File scripts/build_exe.ps1
```

Main files used:

- `src/launcher.py`
- `installer/vehicle-control-scanner.spec`
- `assets/app.ico`

Executable output:

- `dist/vehicle-control-scanner/vehicle-control-scanner.exe`

## Build installer (Setup.exe)

Option A:

```bash
make build-setup
```

Option B:

```bash
pwsh -File scripts/build_setup.ps1
```

Main file used:

- `installer/vehicle-control-scanner.nsi`

Installer output:

- `dist/VehicleControlScanner-Setup-0.1.0.exe`

## What the installer config does

- Installs app to `C:\Program Files\Vehicle Control Scanner`.
- Creates runtime folders:
  - `%ProgramData%\vehicle-control-scanner\data`
  - `%ProgramData%\vehicle-control-scanner\backups`
  - `%ProgramData%\vehicle-control-scanner\logs`
- Creates initial `%ProgramData%\vehicle-control-scanner\.env` from `.env.example` if missing.
- Creates Start Menu and Desktop shortcuts.
- Registers app in Windows uninstall panel.

## Rebuild flow (clean and repeatable)

1. Update code/config.
2. Run `make build-exe`.
3. Run `make build-setup`.
4. Test `dist/VehicleControlScanner-Setup-0.1.0.exe` on a clean machine.
