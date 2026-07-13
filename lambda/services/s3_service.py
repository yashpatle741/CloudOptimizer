import boto3
from botocore.exceptions import ClientError

import os

AWS_REGION = os.getenv("AWS_REGION", "eu-north-1")


class S3Service:
    def __init__(self):
        self.client = boto3.client(
            "s3",
            region_name=AWS_REGION
        )

    def list_buckets(self):
        response = self.client.list_buckets()

        buckets = []

        for bucket in response.get("Buckets", []):

            bucket_name = bucket["Name"]

            # Region
            location = self.client.get_bucket_location(
                Bucket=bucket_name
            )
            region = location.get("LocationConstraint") or "eu-north-1"

            # Versioning
            versioning = self.client.get_bucket_versioning(
                Bucket=bucket_name
            )
            version_status = versioning.get("Status", "Disabled")

            # Public Access Block
            try:
                self.client.get_public_access_block(
                    Bucket=bucket_name
                )
                public = False
            except ClientError:
                public = True

            # Lifecycle
            try:
                self.client.get_bucket_lifecycle_configuration(
                    Bucket=bucket_name
                )
                lifecycle = True
            except ClientError:
                lifecycle = False

            buckets.append({
                "name": bucket_name,
                "created": bucket["CreationDate"].isoformat(),
                "region": region,
                "public": public,
                "versioning": version_status,
                "lifecycle": lifecycle,
            })

        return buckets