locals {
  name_prefix = lower(replace(replace(replace(replace(replace("${var.project_name}-${var.environment}", " ", "-"), "_", "-"), ".", "-"), "/", "-"), ":", "-"))
  common_tags = merge(
    var.tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "Yash"
    }
  )

  lambda_log_group_name = "/aws/lambda/${local.name_prefix}-scanner"
  api_name              = "${local.name_prefix}-api"
  sns_topic_name        = "${local.name_prefix}-notifications"
  dynamodb_table_name   = "${local.name_prefix}-results"
  reports_bucket_name   = "${local.name_prefix}-reports"
}
