# EventBridge Module

This module creates a scheduled EventBridge rule that invokes a Lambda function for recurring CloudOptimizer scans.

## What it creates

- EventBridge rule with a configurable cron expression
- Lambda target
- Lambda permission for EventBridge invocation
