from fastapi import APIRouter
from app.services.aws.ec2_service import EC2Service
from app.services.aws.s3_service import S3Service
from app.services.aws.ebs_service import EBSService

router = APIRouter(tags=["resources"])


@router.get("/resources/ec2")
def get_ec2_resources():

    service = EC2Service()

    return service.list_instances()

@router.get("/resources/s3")
def get_s3_resources():

    service = S3Service()

    return service.list_buckets()

@router.get("/resources/ebs")
def get_ebs_resources():
    service = EBSService()
    return service.list_volumes()

@router.get("/resources")
def get_all_resources():

    resources = []

    ec2 = EC2Service().list_instances()

    for instance in ec2:
        resources.append({
            "id": instance.get("instanceId", instance.get("name")),
            "name": instance.get("name", "Unnamed EC2"),
            "type": "EC2",
            "region": instance.get("region", "eu-north-1"),
            "status": instance.get("state", "Unknown"),
            "cost": 0,
            "details": instance.get("instanceType", "-")
        })

    s3 = S3Service().list_buckets()

    for bucket in s3:
        resources.append({
            "id": bucket["name"],
            "name": bucket["name"],
            "type": "S3",
            "region": bucket["region"],
            "status": "Available",
            "cost": 0,
            "details": f"Versioning: {bucket['versioning']}"
        })

    ebs = EBSService().list_volumes()

    for volume in ebs:
        resources.append({
            "id": volume["id"],
            "name": volume["id"],
            "type": "EBS",
            "region": volume["region"],
            "status": "Attached" if volume["attached"] else "Available",
            "cost": 0,
            "details": f"{volume['size']} GiB"
        })

    return resources