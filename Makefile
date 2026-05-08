.PHONY: dev run

dev:
	uvicorn main:app --reload --app-dir src --host 0.0.0.0 --port 8001

run: dev
