variable "terratowns_access_token" {
  type = string
}

variable "terratowns_endpoint" {
  type = string
}

variable "user_uuid" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "index_html_filepath" {
  type = string
}

variable "error_html_filepath" {
  type = string
}

variable "pre_js_filepath" {
  type = string
}

variable "random_js_filepath" {
  type = string
}

variable "infinity_js_filepath" {
  type = string
}

variable "styles_css_filepath" {
  type = string
}

variable "assets_path" {
  description = "Path to assets folder"
  type = string
}

variable "content_version" {
  description = "Positive integer content version starting at 1"
  
  type        = number
}