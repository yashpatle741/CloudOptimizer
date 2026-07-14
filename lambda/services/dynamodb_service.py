import boto3
import os

AWS_REGION = os.getenv("AWS_REGION", "eu-north-1")


class DynamoDBService:
    def __init__(self):
        self.table = boto3.resource(
            "dynamodb",
            region_name=AWS_REGION
        ).Table("cloudoptimizer-recommendations")

    def delete_all_recommendations(self):
        response = self.table.scan()

        with self.table.batch_writer() as batch:
            for item in response.get("Items", []):
                batch.delete_item(
                    Key={
                        "resourceId": item["resourceId"],
                        "scanTime": item["scanTime"],
                    }
                )

    def save_recommendation(self, recommendation):
        self.table.put_item(Item=recommendation)

    def get_all_recommendations(self):
        response = self.table.scan()
        return response.get("Items", [])