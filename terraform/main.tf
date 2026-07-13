module "iam" {
  source = "./modules/iam"

  project_name        = var.project_name
  environment         = var.environment
  aws_region          = var.aws_region
  dynamodb_table_arns = [module.dynamodb.table_arn]
  sns_topic_arns      = [module.sns.topic_arn]
  s3_bucket_arns      = [module.s3.bucket_arn]
  tags                = local.common_tags
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  project_name          = var.project_name
  environment           = var.environment
  log_group_names       = [local.lambda_log_group_name]
  log_retention_in_days = var.log_retention_in_days
  tags                  = local.common_tags
}

module "dynamodb" {
  source = "./modules/dynamodb"

  project_name = var.project_name
  environment  = var.environment
  table_name   = local.dynamodb_table_name
  tags         = local.common_tags
}

module "sns" {
  source = "./modules/sns"

  project_name               = var.project_name
  environment                = var.environment
  topic_name                 = local.sns_topic_name
  notification_email         = var.notification_email
  email_subscription_enabled = true
  tags                       = local.common_tags
}

module "s3" {
  source = "./modules/s3"

  project_name = var.project_name
  environment  = var.environment
  bucket_name  = local.reports_bucket_name
  lifecycle_rules = [
    {
      id              = "archive-reports"
      status          = "Enabled"
      expiration_days = 90
    }
  ]
  tags = local.common_tags
}

module "lambda" {
  source = "./modules/lambda"

  project_name  = var.project_name
  environment   = var.environment
  function_name = "${local.name_prefix}-scanner"
  filename      = "${path.module}/lambda_payload.zip"
  role_arn      = module.iam.role_arn
  timeout       = var.lambda_timeout
  memory_size   = var.lambda_memory_size
  environment_variables = {
    DYNAMODB_TABLE = module.dynamodb.table_name
    SNS_TOPIC_ARN  = module.sns.topic_arn
    S3_BUCKET      = module.s3.bucket_name
  }
  tags = local.common_tags
}

module "eventbridge" {
  source = "./modules/eventbridge"

  project_name         = var.project_name
  environment          = var.environment
  rule_name            = "${local.name_prefix}-schedule"
  description          = "Scheduled scanner for CloudOptimizer"
  schedule_expression  = var.cron_schedule
  lambda_function_arn  = module.lambda.function_arn
  lambda_function_name = module.lambda.function_name
  tags                 = local.common_tags
}

module "apigateway" {
  source = "./modules/apigateway"

  project_name         = var.project_name
  environment          = var.environment
  api_name             = local.api_name
  lambda_invoke_arn    = module.lambda.invoke_arn
  lambda_function_name = module.lambda.function_name
  tags                 = local.common_tags
}
