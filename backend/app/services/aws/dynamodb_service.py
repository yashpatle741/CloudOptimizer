import boto3

import os

AWS_REGION = os.getenv("AWS_REGION", "eu-north-1")


class DynamoDBService:
    def __init__(self):
        self.table = boto3.resource(
            "dynamodb",
           region_name=AWS_REGION
        ).Table("cloudoptimizer-recommendations")

    def save_recommendation(self, recommendation):
        self.table.put_item(Item=recommendation)

    def get_all_recommendations(self):
        response = self.table.scan()
        return response.get("Items", [])