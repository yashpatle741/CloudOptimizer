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
  description = "Python runtime version for the Lambda function."
  type        = string
  default     = "python3.13"
}

variable "architecture" {
  description = "Lambda architecture."
  type        = string
  default     = "arm64"
}

variable "timeout" {
  description = "Maximum execution time for the Lambda function in seconds."
  type        = number
  default     = 30
}

variable "memory_size" {
  description = "Amount of memory allocated to the Lambda function in MB."
  type        = number
  default     = 512
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function."
  type        = map(string)
  default     = {}
}

variable "reserved_concurrent_executions" {
  description = "Reserved concurrency value for the Lambda function."
  type        = number
  default     = -1
}

variable "publish" {
  description = "Whether to publish a new version of the Lambda function."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to merge into the Lambda function."
  type        = map(string)
  default     = {}
}
