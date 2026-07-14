variable "project_name" {
  description = "Project name used for naming and tagging."
  type        = string
  default     = "CloudOptimizer"
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "dev"
}

variable "topic_name" {
  description = "Name of the SNS topic."
  type        = string
}

variable "notification_email" {
  description = "Email endpoint for SNS subscription."
  type        = string
  default     = null
}

variable "email_subscription_enabled" {
  description = "Whether to create an email subscription."
  type        = bool
  default     = false
}

variable "lambda_function_name" {
  description = "Optional Lambda function name to subscribe to this SNS topic."
  type        = string
  default     = null
}

variable "lambda_function_arn" {
  description = "Optional Lambda function ARN to use for SNS subscription."
  type        = string
  default     = null
}

variable "tags" {
  description = "Additional tags to merge into the SNS topic."
  type        = map(string)
  default     = {}
}
