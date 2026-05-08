from datetime import UTC, datetime

from fastapi import APIRouter
from pydantic import BaseModel

from core.config import settings

router = APIRouter()


class HealthResponse(BaseModel):
    status: str
    app_name: str
    version: str
    environment: str
    timestamp_utc: str


@router.get("/health", response_model=HealthResponse)
async def read_health() -> HealthResponse:
    return HealthResponse(
        status="ok",
        app_name=settings.app_name,
        version=settings.app_version,
        environment=settings.app_env,
        timestamp_utc=datetime.now(UTC).isoformat(),
    )
