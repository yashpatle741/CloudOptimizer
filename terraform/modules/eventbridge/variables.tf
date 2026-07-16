variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "rule_name" {
  description = "EventBridge rule name."
  type        = string
}

variable "description" {
  description = "EventBridge rule description."
  type        = string
  default     = "Scheduled CloudOptimizer scan"
}

variable "schedule_expression" {
  description = "Cron or rate expression."

  type = string

  validation {
    condition = (
      startswith(var.schedule_expression, "rate(") ||
      startswith(var.schedule_expression, "cron(")
    )
    error_message = "schedule_expression must be a valid rate() or cron() expression."
  }
}

variable "state" {
  description = "Rule state."
  type        = string
  default     = "ENABLED"

  validation {
    condition     = contains(["ENABLED", "DISABLED"], var.state)
    error_message = "state must be ENABLED or DISABLED."
  }
}

variable "lambda_function_arn" {
  description = "Lambda ARN."
  type        = string
}

variable "lambda_function_name" {
  description = "Lambda function name."
  type        = string
}

variable "target_id" {
  description = "Event target ID."
  type        = string
  default     = "scanner-target"
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}