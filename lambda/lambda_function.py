from services.recommendation_engine import RecommendationEngine


def lambda_handler(event, context):

    engine = RecommendationEngine()

    recommendations = engine.generate_recommendations()

    return {
        "statusCode": 200,
        "recommendationsGenerated": len(recommendations)
    }