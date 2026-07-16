variable "project_name" {
  description = "Project name used for naming and tagging."
  type        = string
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
}

variable "table_name" {
  description = "Name of the DynamoDB table."
  type        = string
}

variable "deletion_protection_enabled" {
  description = "Whether to enable deletion protection for the table."
  type        = bool
  default     = true
}

variable "point_in_time_recovery_enabled" {
  description = "Whether to enable point-in-time recovery."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags to merge into the table."
  type        = map(string)
  default     = {}
}