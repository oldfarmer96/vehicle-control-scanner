.PHONY: dev run build-exe build-setup set-version

dev:
	uvicorn main:app --reload --app-dir src --host 0.0.0.0 --port 8001

run: dev

build-exe:
	pwsh -File scripts/build_exe.ps1

build-setup:
	pwsh -File scripts/build_setup.ps1

set-version:
	pwsh -File scripts/set_version.ps1 -Version $(VERSION)
