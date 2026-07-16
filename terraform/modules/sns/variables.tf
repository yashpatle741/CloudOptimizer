variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "topic_name" {
  description = "SNS topic name."
  type        = string
}

variable "notification_email" {
  description = "Email address for SNS notifications."
  type        = string
  default     = null
}

variable "email_subscription_enabled" {
  description = "Create email subscription."
  type        = bool
  default     = false
}

variable "lambda_function_name" {
  description = "Lambda function name."
  type        = string
  default     = null
}

variable "lambda_function_arn" {
  description = "Lambda function ARN."
  type        = string
  default     = null
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}