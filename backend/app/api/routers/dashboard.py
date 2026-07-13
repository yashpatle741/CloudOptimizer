from fastapi import APIRouter

from app.services.aws.cost_service import CostService
from app.services.aws.ec2_service import EC2Service
from app.services.aws.s3_service import S3Service
from app.services.aws.ebs_service import EBSService
from app.services.recommendation_engine import RecommendationEngine

router = APIRouter(tags=["dashboard"])


@router.get("/dashboard")
def get_dashboard():

    cost = CostService().get_monthly_cost()

    ec2 = EC2Service().list_instances()
    s3 = S3Service().list_buckets()
    ebs = EBSService().list_volumes()

    recommendations = RecommendationEngine().generate_recommendations()

    high = len(
        [r for r in recommendations if r["priority"] == "High"]
    )

    medium = len(
        [r for r in recommendations if r["priority"] == "Medium"]
    )

    optimization_score = max(
        0,
        100 - (high * 10) - (medium * 5)
    )

    return {
        "monthlyCost": cost["monthlyCost"],
        "potentialSavings": 0,
        "optimizationScore": optimization_score,
        "totalResources": len(ec2) + len(s3) + len(ebs),
        "recentScanStatus": "Completed",

        "latestRecommendations": [
        {
            "id": str(index + 1),
            "title": item["title"],
            "priority": item["priority"],
            "savings": item["estimatedSavings"]
            if isinstance(item["estimatedSavings"], (int, float))
            else 0,
        }
        for index, item in enumerate(recommendations)
    ],

    "resourceDistribution": [
        {
            "name": "EC2",
            "value": len(ec2),
        },
        {
            "name": "S3",
            "value": len(s3),
        },
        {
            "name": "EBS",
            "value": len(ebs),
        },
    ],

    "costTrend": [
        {
            "month": "Current",
            "cost": cost["monthlyCost"],
        }
    ],
    }