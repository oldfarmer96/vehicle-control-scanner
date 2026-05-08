import os
import sys
from pathlib import Path
from shutil import copyfile

import uvicorn


APP_DIR_NAME = "vehicle-control-scanner"


def ensure_runtime_dirs(program_data_root: Path) -> None:
    (program_data_root / "data").mkdir(parents=True, exist_ok=True)
    (program_data_root / "backups").mkdir(parents=True, exist_ok=True)
    (program_data_root / "logs").mkdir(parents=True, exist_ok=True)


def ensure_env_file(program_data_root: Path) -> Path:
    env_path = program_data_root / ".env"
    if env_path.exists():
        return env_path

    local_template = Path(__file__).resolve().parents[1] / ".env.example"
    bundled_template = Path(getattr(sys, "_MEIPASS", "")) / ".env.example"

    template_path = local_template if local_template.exists() else bundled_template
    if template_path.exists():
        copyfile(template_path, env_path)
    else:
        env_path.write_text("APP_ENV=production\n", encoding="utf-8")

    return env_path


def main() -> None:
    program_data = Path(os.getenv("PROGRAMDATA", "C:/ProgramData")) / APP_DIR_NAME
    try:
        ensure_runtime_dirs(program_data)
        env_path = ensure_env_file(program_data)
        os.environ["SCANNER_ENV_FILE"] = str(env_path)

        from main import app
        from core.config import settings

        uvicorn.run(
            app,
            host=settings.host,
            port=settings.port,
            reload=False,
            log_config=None,
        )
    except Exception as exc:
        log_path = program_data / "logs" / "launcher-error.log"
        log_path.parent.mkdir(parents=True, exist_ok=True)
        log_path.write_text(f"{type(exc).__name__}: {exc}\n", encoding="utf-8")
        raise


if __name__ == "__main__":
    main()
