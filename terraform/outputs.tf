output "lambda_name" {
  description = "Name of the scanner Lambda function."
  value       = module.lambda.function_name
}

output "lambda_arn" {
  description = "ARN of the scanner Lambda function."
  value       = module.lambda.function_arn
}

output "api_gateway_url" {
  description = "URL of the deployed API Gateway HTTP API."
  value       = module.apigateway.api_endpoint
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic."
  value       = module.sns.topic_arn
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table."
  value       = module.dynamodb.table_name
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket used for reports."
  value       = module.s3.bucket_name
}

output "iam_role_arn" {
  description = "ARN of the Lambda execution role."
  value       = module.iam.role_arn
}

output "eventbridge_rule_name" {
  description = "Name of the EventBridge schedule rule."
  value       = module.eventbridge.rule_name
}
