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
    condition = (
      length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63 &&
      can(regex("^[a-z0-9][a-z0-9-.]*[a-z0-9]$", var.bucket_name))
    )
    error_message = "The bucket name must be between 3 and 63 characters, start and end with a lowercase letter or number, and can contain only lowercase letters, numbers, hyphens, and dots."
  }
}

variable "index_html_filepath" {
  description = "The file path for index.html"
  type        = string

  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "The provided path for index.html does not exist."
  }
}

variable "error_html_filepath" {
  description = "The file path for error.html"
  type        = string

  validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The provided path for error.html does not exist."
  }
}

# variable "pre_js_filepath" {
#   description = "The file path for pre.js"
#   type        = string

#   validation {
#     condition     = fileexists(var.pre_js_filepath)
#     error_message = "The provided path for pre.js does not exist."
#   }
# }

# variable "random_js_filepath" {
#   description = "The file path for random.js"
#   type        = string

#   validation {
#     condition     = fileexists(var.random_js_filepath)
#     error_message = "The provided path for random.js does not exist."
#   }
# }

# variable "styles_css_filepath" {
#   description = "The file path for styles.css"
#   type        = string

#   validation {
#     condition     = fileexists(var.styles_css_filepath)
#     error_message = "The provided path for styles.css does not exist."
#   }
# }

# variable "assets_path" {
#   description = "Path to assets folder"
#   type        = string
# }

variable "content_version" {
  description = "Positive integer content version starting at 1"

  type = number

  validation {
    condition     = var.content_version > 0
    error_message = "Content version must be a positive integer"
  }

  default = 1
}
