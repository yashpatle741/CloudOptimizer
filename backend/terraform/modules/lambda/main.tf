resource "aws_lambda_function" "this" {
  function_name    = var.function_name
  role             = var.role_arn
  handler          = var.handler
  runtime          = var.runtime
  architectures    = [var.architecture]
  filename         = var.filename
  source_code_hash = var.source_code_hash != null ? var.source_code_hash : filebase64sha256(var.filename)
  timeout          = var.timeout
  memory_size      = var.memory_size
  publish          = var.publish

  reserved_concurrent_executions = var.reserved_concurrent_executions

  environment {
    variables = var.environment_variables
  }

  tags = merge(
    var.tags,
    {
      Name        = var.function_name
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "Yash"
    }
  )
}
