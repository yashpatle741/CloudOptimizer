output "function_name" {
  description = "Name of the Lambda function."
  value       = aws_lambda_function.this.function_name
}

output "function_arn" {
  description = "ARN of the Lambda function."
  value       = aws_lambda_function.this.arn
}

output "invoke_arn" {
  description = "Invoke ARN for API Gateway integration."
  value       = aws_lambda_function.this.invoke_arn
}

output "qualified_arn" {
  description = "Qualified Lambda ARN."
  value       = aws_lambda_function.this.qualified_arn
}

output "version" {
  description = "Published Lambda version."
  value       = aws_lambda_function.this.version
}

output "last_modified" {
  description = "Last modified timestamp."
  value       = aws_lambda_function.this.last_modified
}