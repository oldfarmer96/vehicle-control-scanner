from fastapi import APIRouter

from api.routes.health import router as health_router
from api.routes.root import router as root_router

api_router = APIRouter()
api_router.include_router(root_router)
api_router.include_router(health_router)
