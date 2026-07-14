import boto3
from datetime import date, timedelta


import os

AWS_REGION = os.getenv("AWS_REGION", "eu-north-1")


class CostService:
    def __init__(self):
        self.client = boto3.client(
            "ce",
            region_name=AWS_REGION
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