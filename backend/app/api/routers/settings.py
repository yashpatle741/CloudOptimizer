from fastapi import APIRouter

router = APIRouter(tags=['settings'])

@router.get('/settings')
def get_settings() -> dict:
    return {
        'awsRegion': 'us-east-1',
        'notificationEmail': 'ops-team@company.com',
        'scanSchedule': 'Daily at 02:00 UTC',
        'theme': 'Dark',
        'applicationInfo': 'CloudOptimizer internal operations dashboard'
    }
