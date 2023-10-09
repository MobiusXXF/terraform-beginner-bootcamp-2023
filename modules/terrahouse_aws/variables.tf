variable "user_uuid" {
  description = "User UUID in the format xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  type        = string

  validation {
    condition     = can(regex("^([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})$", var.user_uuid))
    error_message = "User UUID must be in the format xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  }
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string

  validation {
    condition     = (
      length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63 && 
      can(regex("^[a-z0-9][a-z0-9-.]*[a-z0-9]$", var.bucket_name))
    )
    error_message = "The bucket name must be between 3 and 63 characters, start and end with a lowercase letter or number, and can contain only lowercase letters, numbers, hyphens, and dots."
  }
}

variable "public_path" {
  description = "The file path for public directory"
  type        = string
}

variable "pre_js_filepath" {
  description = "The file path for pre.js"
  type        = string
  default = "null"
}

variable "random_js_filepath" {
  description = "The file path for random.js"
  type        = string
  default = "null"
}

variable "infinity_js_filepath" {
  description = "The file path for infinity.js"
  type        = string
  default = "null"
}

variable "content_version" {
  description = "Positive integer content version starting at 1"
  
  type        = number
  
  validation {
    condition     = var.content_version > 0
    error_message = "Content version must be a positive integer"
  }

  default     = 1
}