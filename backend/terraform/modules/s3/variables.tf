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

variable "bucket_name" {
  description = "Name of the S3 bucket used for reports."
  type        = string
}

variable "lifecycle_rules" {
  description = "Optional lifecycle rules to apply to the bucket."
  type = list(object({
    id              = string
    status          = string
    filter          = optional(object({ prefix = optional(string) }))
    expiration_days = optional(number)
  }))
  default = []
}

variable "tags" {
  description = "Additional tags to merge into the bucket."
  type        = map(string)
  default     = {}
}
