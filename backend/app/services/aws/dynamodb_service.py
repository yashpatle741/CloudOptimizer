import boto3
from app.core.config import get_settings

settings = get_settings()


class DynamoDBService:
    def __init__(self):
        self.table = boto3.resource(
            "dynamodb",
            region_name=settings.aws_region,
        ).Table("cloudoptimizer-recommendations")

    def save_recommendation(self, recommendation):
        self.table.put_item(Item=recommendation)

    def get_all_recommendations(self):
        response = self.table.scan()
        return response.get("Items", [])