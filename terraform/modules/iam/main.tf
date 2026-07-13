data "aws_caller_identity" "current" {}

locals {
  effective_role_name   = coalesce(var.role_name, "${lower(replace(var.project_name, "/[^a-zA-Z0-9]+/", "-"))}-${var.environment}-lambda-exec")
  effective_policy_name = coalesce(var.policy_name, "${lower(replace(var.project_name, "/[^a-zA-Z0-9]+/", "-"))}-${var.environment}-lambda-policy")

  policy_statements = concat(
    [
      {
        sid       = "DynamoDBReadWrite"
        effect    = "Allow"
        actions   = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:UpdateItem", "dynamodb:DeleteItem", "dynamodb:Query", "dynamodb:Scan", "dynamodb:BatchGetItem", "dynamodb:BatchWriteItem"]
        resources = var.dynamodb_table_arns
      },
      {
        sid       = "SNSPublish"
        effect    = "Allow"
        actions   = ["sns:Publish"]
        resources = var.sns_topic_arns
      },
      {
        sid       = "CostExplorerRead"
        effect    = "Allow"
        actions   = ["ce:GetCostAndUsage", "ce:GetDimensionValues", "ce:GetReservationUtilization", "ce:GetTags"]
        resources = ["*"]
      },
      {
        sid       = "EC2Describe"
        effect    = "Allow"
        actions   = ["ec2:Describe*"]
        resources = ["*"]
      },
      {
        sid       = "EBSDescribe"
        effect    = "Allow"
        actions   = ["ebs:Describe*"]
        resources = ["*"]
      }
    ],
    length(var.s3_bucket_arns) > 0 ? [
      {
        sid       = "S3ReadOnly"
        effect    = "Allow"
        actions   = ["s3:Get*", "s3:List*"]
        resources = concat(var.s3_bucket_arns, formatlist("%s/*", var.s3_bucket_arns))
      }
    ] : [],
    var.additional_policy_statements
  )
}

resource "aws_iam_role" "lambda_execution" {
  name        = local.effective_role_name
  description = "Execution role for CloudOptimizer Lambda functions"
  path        = var.path

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(
    var.tags,
    {
      Name        = local.effective_role_name
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "Yash"
    }
  )
}

resource "aws_iam_policy" "lambda_execution" {
  name        = local.effective_policy_name
  path        = var.path
  description = "Least-privilege permissions for CloudOptimizer Lambda execution"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      for statement in local.policy_statements : {
        Sid      = try(statement.sid, null)
        Effect   = statement.effect
        Action   = statement.actions
        Resource = statement.resources
      }
    ]
  })

  tags = merge(
    var.tags,
    {
      Name        = local.effective_policy_name
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "Yash"
    }
  )
}

resource "aws_iam_role_policy_attachment" "basic_execution" {
  role       = aws_iam_role.lambda_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "custom" {
  role       = aws_iam_role.lambda_execution.name
  policy_arn = aws_iam_policy.lambda_execution.arn
}
