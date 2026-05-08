from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    app_name: str = "vehicle-control-scanner"
    app_version: str = "0.1.0"
    app_env: str = "dev"

    api_base_url: str = "http://localhost:4000"
    api_prefix: str = "api/v1"
    webhook_api_key: str = ""

    sqlite_path: str = "data/scanner.db"
    backup_dir: str = "backups"

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=False,
        extra="ignore",
    )


settings = Settings()
