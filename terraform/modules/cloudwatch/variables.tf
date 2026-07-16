variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "log_group_names" {
  description = "CloudWatch log groups."
  type        = list(string)
  default     = []
}

variable "log_retention_in_days" {
  description = "Log retention in days."
  type        = number
  default     = 30

  validation {
    condition = contains([
      1, 3, 5, 7, 14, 30, 60, 90, 120,
      150, 180, 365, 400, 545, 731,
      1096, 1827, 2192, 2557, 2922,
      3288, 3653
    ], var.log_retention_in_days)
    error_message = "Invalid CloudWatch log retention value."
  }
}

variable "kms_key_id" {
  description = "Optional KMS Key ARN."
  type        = string
  default     = null
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}

variable "alarm_enabled" {
  description = "Create CloudWatch alarm."
  type        = bool
  default     = false
}

variable "alarm_name" {
  description = "Alarm name."
  type        = string
  default     = null
}

variable "comparison_operator" {
  description = "Comparison operator."
  type        = string
  default     = "GreaterThanThreshold"
}

variable "evaluation_periods" {
  description = "Evaluation periods."
  type        = number
  default     = 1
}

variable "metric_name" {
  description = "Metric name."
  type        = string
  default     = "Errors"
}

variable "namespace" {
  description = "Metric namespace."
  type        = string
  default     = "AWS/Lambda"
}

variable "period" {
  description = "Metric period."
  type        = number
  default     = 300
}

variable "statistic" {
  description = "Metric statistic."
  type        = string
  default     = "Sum"
}

variable "threshold" {
  description = "Alarm threshold."
  type        = number
  default     = 5
}

variable "alarm_description" {
  description = "Alarm description."
  type        = string
  default     = "CloudOptimizer Lambda Error Alarm"
}

variable "treat_missing_data" {
  description = "Treat missing data."
  type        = string
  default     = "notBreaching"
}

variable "alarm_actions" {
  description = "Alarm actions."
  type        = list(string)
  default     = []
}

variable "ok_actions" {
  description = "OK actions."
  type        = list(string)
  default     = []
}

variable "insufficient_data_actions" {
  description = "Insufficient data actions."
  type        = list(string)
  default     = []
}