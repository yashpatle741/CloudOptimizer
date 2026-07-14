variable "aws_region" {
  description = "AWS region for all resources."
  type        = string
  default     = "eu-north-1"
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name used in naming and tags."
  type        = string
  default     = "CloudOptimizer"
}

variable "lambda_memory_size" {
  description = "Memory allocated to Lambda functions in MB."
  type        = number
  default     = 512
}

variable "lambda_timeout" {
  description = "Timeout for Lambda functions in seconds."
  type        = number
  default     = 30
}

variable "log_retention_in_days" {
  description = "CloudWatch log retention period in days."
  type        = number
  default     = 30
}

variable "cron_schedule" {
  description = "Cron expression for the scanner schedule."
  type        = string
  default     = "cron(0 * * * ? *)"
}

variable "notification_email" {
  description = "Email address for SNS notifications."
  type        = string
  default     = "yashpatle99@gmail.com"
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default = {
    Project     = "CloudOptimizer"
    Environment = "dev"
    ManagedBy   = "Terraform"
    Owner       = "Yash"
  }
}
