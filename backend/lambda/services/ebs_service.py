import boto3


import os

AWS_REGION = os.getenv("AWS_REGION", "eu-north-1")


class EBSService:
    def __init__(self):
        self.client = boto3.client(
            "ec2",
            region_name=AWS_REGION
        )

    def list_volumes(self):
        response = self.client.describe_volumes()

        volumes = []

        for volume in response.get("Volumes", []):

            attached = len(volume.get("Attachments", [])) > 0

            volumes.append({
                "id": volume["VolumeId"],
                "type": volume["VolumeType"],
                "size": volume["Size"],
                "state": volume["State"]["Name"],
                "attached": attached,
                "availabilityZone": volume["AvailabilityZone"],
                "encrypted": volume["Encrypted"],
                "created": volume["CreateTime"].isoformat(),
            })

        return volumes