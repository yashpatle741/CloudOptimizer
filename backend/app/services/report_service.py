from datetime import datetime

from app.services.aws.cost_service import CostService
from app.services.aws.ec2_service import EC2Service
from app.services.aws.s3_service import S3Service
from app.services.aws.ebs_service import EBSService
from app.services.aws.dynamodb_service import DynamoDBService


def generate_reports():

    cost = CostService().get_monthly_cost()

    ec2 = EC2Service().list_instances()
    s3 = S3Service().list_buckets()
    ebs = EBSService().list_volumes()

    db = DynamoDBService()
    recommendations = db.get_all_recommendations()

    total_resources = len(ec2) + len(s3) + len(ebs)

    return [
        {
            "id": "1",
            "scanDate": datetime.now().strftime("%Y-%m-%d"),
            "resourcesScanned": total_resources,
            "recommendationsFound": len(recommendations),
            "costBefore": cost["monthlyCost"],
            "costAfter": cost["monthlyCost"],
        }
    ]