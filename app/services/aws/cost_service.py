import boto3
from datetime import date, timedelta

from app.core.config import get_settings

settings = get_settings()


class CostService:
    def __init__(self):
        self.client = boto3.client(
            "ce",
            region_name="us-east-1"
        )

    def get_monthly_cost(self):
        today = date.today()
        first_day = today.replace(day=1)

        response = self.client.get_cost_and_usage(
            TimePeriod={
                "Start": first_day.isoformat(),
                "End": today.isoformat(),
            },
            Granularity="MONTHLY",
            Metrics=["UnblendedCost"],
        )

        amount = response["ResultsByTime"][0]["Total"]["UnblendedCost"]["Amount"]

        return {
            "monthlyCost": round(float(amount), 2),
            "currency": response["ResultsByTime"][0]["Total"]["UnblendedCost"]["Unit"],
            "period": "Current Month"
        }