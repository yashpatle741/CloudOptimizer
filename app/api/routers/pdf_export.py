from io import BytesIO

from fastapi import APIRouter
from fastapi.responses import StreamingResponse
from reportlab.platypus import SimpleDocTemplate, Table

from app.api.routers.reports import get_reports

router = APIRouter(tags=["export"])


@router.get("/export/pdf")
def export_pdf():

    reports = get_reports()

    buffer = BytesIO()

    pdf = SimpleDocTemplate(buffer)

    data = [
        [
            "Date",
            "Resources",
            "Recommendations",
            "Cost Before",
            "Cost After",
        ]
    ]

    for report in reports:
        data.append([
            report["scanDate"],
            report["resourcesScanned"],
            report["recommendationsFound"],
            report["costBefore"],
            report["costAfter"],
        ])

    pdf.build([Table(data)])

    buffer.seek(0)

    return StreamingResponse(
        buffer,
        media_type="application/pdf",
        headers={
            "Content-Disposition": "attachment; filename=cloudoptimizer-report.pdf"
        },
    )