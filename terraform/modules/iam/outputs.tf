output "role_name" {
  description = "Name of the IAM role created for Lambda execution."
  value       = aws_iam_role.lambda_execution.name
}

output "role_arn" {
  description = "ARN of the IAM role created for Lambda execution."
  value       = aws_iam_role.lambda_execution.arn
}

output "policy_name" {
  description = "Name of the IAM policy attached to the Lambda execution role."
  value       = aws_iam_policy.lambda_execution.name
}

output "policy_arn" {
  description = "ARN of the IAM policy attached to the Lambda execution role."
  value       = aws_iam_policy.lambda_execution.arn
}
