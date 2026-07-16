variable "project_name" {
  description = "Name of the project used for resource naming and tagging."
  type        = string

  validation {
    condition     = length(trimspace(var.project_name)) > 0
    error_message = "project_name must not be empty."
  }
}

variable "environment" {
  description = "Deployment environment name such as dev, test, or prod."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.environment))
    error_message = "environment must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "role_name" {
  description = "Optional override for the IAM role name."
  type        = string
  default     = null
}

variable "policy_name" {
  description = "Optional override for the IAM policy name."
  type        = string
  default     = null
}

variable "path" {
  description = "Path for the IAM role and policy."
  type        = string
  default     = "/service-role/"

  validation {
    condition     = startswith(var.path, "/") && endswith(var.path, "/")
    error_message = "path must start and end with '/'."
  }
}

variable "aws_region" {
  description = "AWS region."
  type        = string
}

variable "tags" {
  description = "Tags applied to IAM resources."
  type        = map(string)
  default     = {}
}

variable "dynamodb_table_arns" {
  description = "DynamoDB table ARNs."
  type        = list(string)
  default     = []
}

variable "sns_topic_arns" {
  description = "SNS topic ARNs."
  type        = list(string)
  default     = []
}

variable "s3_bucket_arns" {
  description = "S3 bucket ARNs."
  type        = list(string)
  default     = []
}

variable "additional_policy_statements" {
  description = "Additional IAM policy statements."

  type = list(object({
    sid       = optional(string)
    effect    = string
    actions   = list(string)
    resources = list(string)
  }))

  default = []
}