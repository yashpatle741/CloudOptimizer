variable "project_name" {
  description = "Name of the project used for resource naming and tagging."
  type        = string
  default     = "CloudOptimizer"

  validation {
    condition     = length(trimspace(var.project_name)) > 0
    error_message = "project_name must not be empty."
  }
}

variable "environment" {
  description = "Deployment environment name such as dev, test, or prod."
  type        = string
  default     = "dev"

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
  description = "Path to attach the IAM role and policy."
  type        = string
  default     = "/service-role/"

  validation {
    condition     = startswith(var.path, "/") && endswith(var.path, "/")
    error_message = "path must start and end with a forward slash."
  }
}

variable "aws_region" {
  description = "AWS region used by the module for resource targeting and tagging."
  type        = string
  default     = "eu-north-1"
}

variable "tags" {
  description = "Additional tags to merge into all IAM resources."
  type        = map(string)
  default     = {}
}

variable "dynamodb_table_arns" {
  description = "List of DynamoDB table ARNs that the Lambda execution role may access."
  type        = list(string)
  default     = []
}

variable "sns_topic_arns" {
  description = "List of SNS topic ARNs that the Lambda execution role may publish to."
  type        = list(string)
  default     = []
}

variable "s3_bucket_arns" {
  description = "List of S3 bucket ARNs that the Lambda execution role may read from."
  type        = list(string)
  default     = []
}

variable "additional_policy_statements" {
  description = "Optional policy statements to append to the base least-privilege policy."
  type = list(object({
    sid       = optional(string)
    effect    = string
    actions   = list(string)
    resources = list(string)
  }))
  default = []
}
