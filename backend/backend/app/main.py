from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api.routers import dashboard, resources, recommendations, reports, settings, health
from app.api.routers import export
from app.api.routers import pdf_export

app = FastAPI(title='CloudOptimizer API', version='1.0.0')

app.add_middleware(
    CORSMiddleware,
    allow_origins=['*'],
    allow_credentials=True,
    allow_methods=['*'],
    allow_headers=['*'],
)

app.include_router(health.router, prefix='/api/v1')
app.include_router(dashboard.router, prefix='/api/v1')
app.include_router(resources.router, prefix='/api/v1')
app.include_router(recommendations.router, prefix='/api/v1')
app.include_router(reports.router, prefix='/api/v1')
app.include_router(settings.router, prefix='/api/v1')
app.include_router(export.router, prefix="/api/v1")
app.include_router(pdf_export.router, prefix="/api/v1")
