variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "bucket_name" {
  description = "S3 bucket name."
  type        = string
}

variable "lifecycle_rules" {
  description = "S3 lifecycle rules."

  type = list(object({
    id     = string
    status = string
    filter = optional(object({
      prefix = optional(string)
    }))
    expiration_days = optional(number)
  }))

  default = []
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}