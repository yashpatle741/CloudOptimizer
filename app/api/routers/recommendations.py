from fastapi import APIRouter

from app.services.recommendation_engine import RecommendationEngine

router = APIRouter(tags=["recommendations"])


@router.get("/recommendations")
def get_recommendations():

    engine = RecommendationEngine()

    return engine.generate_recommendations()