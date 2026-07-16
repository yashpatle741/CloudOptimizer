output "role_name" {
  description = "IAM role name."
  value       = aws_iam_role.lambda_execution.name
}

output "role_arn" {
  description = "IAM role ARN."
  value       = aws_iam_role.lambda_execution.arn
}

output "policy_name" {
  description = "IAM policy name."
  value       = aws_iam_policy.lambda_execution.name
}

output "policy_arn" {
  description = "IAM policy ARN."
  value       = aws_iam_policy.lambda_execution.arn
}