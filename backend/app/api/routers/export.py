from io import StringIO, BytesIO

import pandas as pd
from fastapi import APIRouter
from fastapi.responses import StreamingResponse
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas

from app.services.report_service import generate_reports

router = APIRouter(tags=["export"])


@router.get("/export/csv")
def export_csv():

    reports = generate_reports()

    df = pd.DataFrame(reports)

    output = StringIO()
    df.to_csv(output, index=False)
    output.seek(0)

    return StreamingResponse(
        output,
        media_type="text/csv",
        headers={
            "Content-Disposition": "attachment; filename=cloudoptimizer-report.csv"
        },
    )


@router.get("/export/pdf")
def export_pdf():

    reports = generate_reports()

    buffer = BytesIO()

    pdf = canvas.Canvas(buffer, pagesize=letter)

    pdf.setTitle("CloudOptimizer Report")

    pdf.setFont("Helvetica-Bold", 18)
    pdf.drawString(50, 760, "CloudOptimizer Report")

    pdf.setFont("Helvetica", 12)

    y = 720

    for report in reports:
        pdf.drawString(50, y, f"Scan Date: {report['scanDate']}")
        y -= 20

        pdf.drawString(
            50,
            y,
            f"Resources Scanned: {report['resourcesScanned']}",
        )
        y -= 20

        pdf.drawString(
            50,
            y,
            f"Recommendations: {report['recommendationsFound']}",
        )
        y -= 20

        pdf.drawString(
            50,
            y,
            f"Cost Before: ${report['costBefore']}",
        )
        y -= 20

        pdf.drawString(
            50,
            y,
            f"Cost After: ${report['costAfter']}",
        )
        y -= 40

    pdf.save()

    buffer.seek(0)

    return StreamingResponse(
        buffer,
        media_type="application/pdf",
        headers={
            "Content-Disposition": "attachment; filename=cloudoptimizer-report.pdf"
        },
    )