variable "project_name" {
  description = "Project name used for naming and tagging."
  type        = string
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
}

variable "function_name" {
  description = "Name of the Lambda function."
  type        = string
}

variable "filename" {
  description = "Path to the Lambda deployment package zip file."
  type        = string
}

variable "source_code_hash" {
  description = "Optional base64 SHA-256 hash of the deployment package."
  type        = string
  default     = null
}

variable "role_arn" {
  description = "ARN of the IAM role attached to the Lambda function."
  type        = string
}

variable "handler" {
  description = "Lambda handler entry point."
  type        = string
  default     = "handler.lambda_handler"
}

variable "runtime" {
  description = "Python runtime version."
  type        = string
  default     = "python3.13"
}

variable "architecture" {
  description = "Lambda architecture."
  type        = string
  default     = "arm64"

  validation {
    condition     = contains(["arm64", "x86_64"], var.architecture)
    error_message = "Architecture must be arm64 or x86_64."
  }
}

variable "timeout" {
  description = "Lambda timeout in seconds."
  type        = number
  default     = 30
}

variable "memory_size" {
  description = "Lambda memory in MB."
  type        = number
  default     = 512

  validation {
    condition     = var.memory_size >= 128 && var.memory_size <= 10240
    error_message = "Memory must be between 128 and 10240 MB."
  }
}

variable "log_retention_in_days" {
  description = "CloudWatch log retention."
  type        = number
  default     = 30
}

variable "environment_variables" {
  description = "Environment variables."
  type        = map(string)
  default     = {}
}

variable "reserved_concurrent_executions" {
  description = "Reserved concurrency."
  type        = number
  default     = -1
}

variable "publish" {
  description = "Publish a new Lambda version."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}