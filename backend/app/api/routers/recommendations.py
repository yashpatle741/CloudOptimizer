from fastapi import APIRouter

from app.services.aws.dynamodb_service import DynamoDBService

router = APIRouter(tags=["recommendations"])


@router.get("/recommendations")
def get_recommendations():
    db = DynamoDBService()
    return db.get_all_recommendations()