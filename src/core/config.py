import os
from pathlib import Path

from pydantic_settings import BaseSettings, SettingsConfigDict


APP_DATA_ROOT = Path(os.getenv("PROGRAMDATA", "C:/ProgramData")) / "vehicle-control-scanner"
DEFAULT_ENV_FILE = APP_DATA_ROOT / ".env"


class Settings(BaseSettings):
    app_name: str = "vehicle-control-scanner"
    app_version: str = "0.1.0"
    app_env: str = "production"

    host: str = "127.0.0.1"
    port: int = 8001

    api_base_url: str = "http://localhost:4000"
    api_prefix: str = "api/v1"
    webhook_api_key: str = ""

    sqlite_path: str = str(APP_DATA_ROOT / "data" / "scanner.db")
    backup_dir: str = str(APP_DATA_ROOT / "backups")
    log_dir: str = str(APP_DATA_ROOT / "logs")

    model_config = SettingsConfigDict(
        env_file=os.getenv("SCANNER_ENV_FILE", str(DEFAULT_ENV_FILE)),
        env_file_encoding="utf-8",
        case_sensitive=False,
        extra="ignore",
    )


settings = Settings()
