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

variable "log_group_names" {
  description = "List of CloudWatch log groups to create."
  type        = list(string)
  default     = []
}

variable "log_retention_in_days" {
  description = "CloudWatch log retention period in days."
  type        = number
  default     = 30
}

variable "kms_key_id" {
  description = "Optional KMS key ARN for CloudWatch log group encryption."
  type        = string
  default     = null
}

variable "tags" {
  description = "Additional tags to merge into the log groups."
  type        = map(string)
  default     = {}
}

variable "alarm_enabled" {
  description = "Whether to create an optional CloudWatch alarm."
  type        = bool
  default     = false
}

variable "alarm_name" {
  description = "Optional custom name for the alarm."
  type        = string
  default     = null
}

variable "comparison_operator" {
  description = "CloudWatch alarm comparison operator."
  type        = string
  default     = "GreaterThanThreshold"
}

variable "evaluation_periods" {
  description = "Number of evaluation periods for the alarm."
  type        = number
  default     = 1
}

variable "metric_name" {
  description = "Metric name for the alarm."
  type        = string
  default     = "Errors"
}

variable "namespace" {
  description = "Namespace for the alarm metric."
  type        = string
  default     = "AWS/Lambda"
}

variable "period" {
  description = "Alarm evaluation period in seconds."
  type        = number
  default     = 300
}

variable "statistic" {
  description = "Statistic used for the alarm."
  type        = string
  default     = "Sum"
}

variable "threshold" {
  description = "Alarm threshold value."
  type        = number
  default     = 5
}

variable "alarm_description" {
  description = "Description for the alarm."
  type        = string
  default     = "Alarm for CloudOptimizer Lambda errors"
}

variable "treat_missing_data" {
  description = "How missing data should be treated by the alarm."
  type        = string
  default     = "notBreaching"
}

variable "alarm_actions" {
  description = "List of actions to trigger when the alarm enters an ALARM state."
  type        = list(string)
  default     = []
}

variable "ok_actions" {
  description = "List of actions to trigger when the alarm returns to OK."
  type        = list(string)
  default     = []
}

variable "insufficient_data_actions" {
  description = "List of actions to trigger when the alarm enters INSUFFICIENT_DATA."
  type        = list(string)
  default     = []
}
