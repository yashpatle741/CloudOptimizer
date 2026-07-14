resource "aws_sns_topic" "this" {
  name = var.topic_name

  tags = merge(
    var.tags,
    {
      Name        = var.topic_name
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "Yash"
    }
  )
}

resource "aws_sns_topic_subscription" "email" {
  count = var.email_subscription_enabled ? 1 : 0

  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = var.notification_email
}

resource "aws_lambda_permission" "allow_sns" {
  count = var.lambda_function_name != null && var.lambda_function_arn != null ? 1 : 0

  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.this.arn
}

resource "aws_sns_topic_subscription" "lambda" {
  count = var.lambda_function_name != null && var.lambda_function_arn != null ? 1 : 0

  topic_arn = aws_sns_topic.this.arn
  protocol  = "lambda"
  endpoint  = var.lambda_function_arn
}
