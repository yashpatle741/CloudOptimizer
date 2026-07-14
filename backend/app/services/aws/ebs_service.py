import boto3

from app.core.config import get_settings

settings = get_settings()


class EBSService:
    def __init__(self):
        self.client = boto3.client(
            "ec2",
            region_name=settings.aws_region,
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
                "state": volume["State"],
                "attached": attached,
                "availabilityZone": volume["AvailabilityZone"],
                "region": settings.aws_region,
                "encrypted": volume["Encrypted"],
                "created": volume["CreateTime"].isoformat(),
            })

        return volumes