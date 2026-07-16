variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "api_name" {
  description = "HTTP API name."
  type        = string
}

variable "description" {
  description = "HTTP API description."
  type        = string
  default     = "CloudOptimizer HTTP API"
}

variable "allowed_origins" {
  description = "Allowed CORS origins."
  type        = list(string)
  default     = ["*"]
}

variable "allowed_methods" {
  description = "Allowed CORS methods."
  type        = list(string)
  default     = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
}

variable "allowed_headers" {
  description = "Allowed CORS headers."
  type        = list(string)
  default = [
    "content-type",
    "authorization"
  ]
}

variable "max_age" {
  description = "CORS preflight cache duration."
  type        = number
  default     = 300
}

variable "lambda_invoke_arn" {
  description = "Lambda invoke ARN."
  type        = string
}

variable "lambda_function_name" {
  description = "Lambda function name."
  type        = string
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}