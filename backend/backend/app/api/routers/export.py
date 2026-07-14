from io import StringIO

import pandas as pd
from fastapi import APIRouter
from fastapi.responses import StreamingResponse

from app.api.routers.reports import get_reports

router = APIRouter(tags=["export"])


@router.get("/export/csv")
def export_csv():

    reports = get_reports()

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