# Windows Build and Installer Guide

This guide explains how to rebuild the executable and generate the NSIS installer.

## Version source

- Release version is stored in `VERSION`.
- Default current value: `0.1.0`.
- NSIS installer name uses this version automatically.

Update version:

```bash
pwsh -File scripts/set_version.ps1 -Version 0.1.1
```

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

- `dist/VehicleControlScanner-Setup-<VERSION>.exe`

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
4. Test `dist/VehicleControlScanner-Setup-<VERSION>.exe` on a clean machine.

## Publish Release on GitHub (web UI)

1. Push changes to `main`.
2. Update `CHANGELOG.md` moving items from `Unreleased` to the new version section.
3. In GitHub repo, open `Releases`.
4. Click `Draft a new release`.
5. Create tag like `v0.1.1` (must match `VERSION`).
6. Release title: `Vehicle Control Scanner v0.1.1`.
7. In description add summary of changes (you can copy from `CHANGELOG.md`).
8. Upload file `dist/VehicleControlScanner-Setup-0.1.1.exe`.
9. Click `Publish release`.

Recommended release assets:

- `VehicleControlScanner-Setup-<VERSION>.exe`
- Optional checksum file (`SHA256SUMS.txt`).
