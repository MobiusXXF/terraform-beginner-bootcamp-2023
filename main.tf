# terraform {
#   cloud {
#     organization = "TheDevAnt"

#     workspaces {
#       name = "terra-house-soul"
#     }
#   }
# }

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
  index_html_filepath = var.error_html_filepath
  error_html_filepath = var.error_html_filepath
}