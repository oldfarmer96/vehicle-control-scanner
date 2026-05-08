from fastapi import APIRouter
from pydantic import BaseModel

from core.config import settings

router = APIRouter()


class RootResponse(BaseModel):
    app_name: str
    version: str
    environment: str


@router.get("/", response_model=RootResponse)
async def read_root() -> RootResponse:
    return RootResponse(
        app_name=settings.app_name,
        version=settings.app_version,
        environment=settings.app_env,
    )
