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

variable "soul" {
  type = object({
    public_path = string
    content_version = number
})  
}

variable "flags" {
  type = object({
    public_path = string
    content_version = number
})  
}

variable "pre_js_filepath" {
  type = string
  default = "null"
}

variable "random_js_filepath" {
  type = string
  default = "null"
}

variable "infinity_js_filepath" {
  type = string
  default = "null"
}


variable "content_version" {
  description = "Positive integer content version starting at 1"

  type = number
}