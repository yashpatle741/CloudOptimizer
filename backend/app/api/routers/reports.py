from fastapi import APIRouter

from app.services.report_service import generate_reports

router = APIRouter(tags=["reports"])


@router.get("/reports")
def get_reports():
    return generate_reports()