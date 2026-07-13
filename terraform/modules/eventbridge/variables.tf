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

variable "rule_name" {
  description = "Name of the EventBridge rule."
  type        = string
}

variable "description" {
  description = "Description of the EventBridge rule."
  type        = string
  default     = "Scheduled CloudOptimizer scan"
}

variable "schedule_expression" {
  description = "Cron or rate expression for the EventBridge rule."
  type        = string
}

variable "state" {
  description = "State of the EventBridge rule."
  type        = string
  default     = "ENABLED"
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function invoked by the rule."
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function invoked by the rule."
  type        = string
}

variable "target_id" {
  description = "Identifier for the EventBridge target."
  type        = string
  default     = "scanner-target"
}

variable "tags" {
  description = "Additional tags to merge into the EventBridge resources."
  type        = map(string)
  default     = {}
}
