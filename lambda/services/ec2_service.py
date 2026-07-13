import boto3


import os

AWS_REGION = os.getenv("AWS_REGION", "eu-north-1")


class EC2Service:
    def __init__(self):
        self.client = boto3.client(
            "ec2",
            region_name=AWS_REGION
        )

    def list_instances(self):
        response = self.client.describe_instances()

        instances = []

        for reservation in response["Reservations"]:
            for instance in reservation["Instances"]:

                name = "Unnamed"

                for tag in instance.get("Tags", []):
                    if tag["Key"] == "Name":
                        name = tag["Value"]

                instances.append({
                    "id": instance["InstanceId"],
                    "name": name,
                    "type": instance["InstanceType"],
                    "state": instance["State"]["Name"],
                    "az": instance["Placement"]["AvailabilityZone"],
                    "launchTime": instance["LaunchTime"].isoformat(),
                })

        return instances