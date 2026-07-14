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

variable "api_name" {
  description = "Name of the HTTP API."
  type        = string
}

variable "description" {
  description = "Description of the HTTP API."
  type        = string
  default     = "CloudOptimizer HTTP API"
}

variable "allowed_origins" {
  description = "List of allowed CORS origins."
  type        = list(string)
  default     = ["*"]
}

variable "allowed_methods" {
  description = "List of allowed CORS methods."
  type        = list(string)
  default     = ["GET", "POST", "OPTIONS"]
}

variable "allowed_headers" {
  description = "List of allowed CORS headers."
  type        = list(string)
  default     = ["content-type", "authorization"]
}

variable "max_age" {
  description = "Maximum age in seconds for CORS preflight cache."
  type        = number
  default     = 300
}

variable "lambda_invoke_arn" {
  description = "Invoke ARN for the Lambda integration."
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function invoked by the API."
  type        = string
}

variable "tags" {
  description = "Additional tags to merge into the API resources."
  type        = map(string)
  default     = {}
}
