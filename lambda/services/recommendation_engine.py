from datetime import datetime, UTC

from services.ec2_service import EC2Service
from services.s3_service import S3Service
from services.ebs_service import EBSService
from services.dynamodb_service import DynamoDBService


class RecommendationEngine:

    def generate_recommendations(self):
        recommendations = []

        recommendations.extend(self.check_ec2())
        recommendations.extend(self.check_s3())
        recommendations.extend(self.check_ebs())

        db = DynamoDBService()

        # Remove old recommendations before saving new ones
        db.delete_all_recommendations()

        for recommendation in recommendations:
            db.save_recommendation({
                "resourceId": recommendation["resource"],
                "scanTime": datetime.now(UTC).isoformat(),
                "service": recommendation["service"],
                "title": recommendation["title"],
                "priority": recommendation["priority"],
                "description": recommendation["description"],
                "estimatedSavings": recommendation["estimatedSavings"],
            })

        return recommendations

    def check_ec2(self):
        recommendations = []

        ec2_instances = EC2Service().list_instances()

        for instance in ec2_instances:
            if instance["state"] == "stopped":
                recommendations.append({
                    "resource": instance["name"],
                    "service": "EC2",
                    "priority": "High",
                    "title": "Terminate stopped EC2 instance",
                    "description": "Stopped instances may still incur storage charges.",
                    "estimatedSavings": "Review Required",
                })

        return recommendations

    def check_s3(self):
        recommendations = []

        buckets = S3Service().list_buckets()

        for bucket in buckets:

            if bucket["public"]:
                recommendations.append({
                    "resource": bucket["name"],
                    "service": "S3",
                    "priority": "High",
                    "title": "Enable Block Public Access",
                    "description": "Bucket is publicly accessible.",
                    "estimatedSavings": "-",
                })

            if not bucket["lifecycle"]:
                recommendations.append({
                    "resource": bucket["name"],
                    "service": "S3",
                    "priority": "Medium",
                    "title": "Enable Lifecycle Policy",
                    "description": "Lifecycle rules can reduce storage costs.",
                    "estimatedSavings": "Potential",
                })

        return recommendations

    def check_ebs(self):
        recommendations = []

        volumes = EBSService().list_volumes()

        for volume in volumes:
            if not volume["attached"]:
                recommendations.append({
                    "resource": volume["id"],
                    "service": "EBS",
                    "priority": "High",
                    "title": "Delete Unattached Volume",
                    "description": "Unattached EBS volumes continue to incur charges.",
                    "estimatedSavings": "Depends on size",
                })

        return recommendations