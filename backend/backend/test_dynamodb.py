from datetime import datetime
from app.services.aws.dynamodb_service import DynamoDBService

db = DynamoDBService()

db.save_recommendation({
    "resourceId": "test-resource",
    "scanTime": datetime.utcnow().isoformat(),
    "service": "EC2",
    "title": "Test Recommendation",
    "priority": "High"
})

print(db.get_all_recommendations())