terraform {
  cloud {
    organization = "TheDevAnt"
    workspaces {
      name = "terraform-cloud"
    }
  }
}


module "terrahouse_aws" {
  source      = "./modules/terrahouse_aws"
  user_uuid   = var.user_uuid
  bucket_name = var.bucket_name
  # index_html_filepath = var.index_html_filepath
  # error_html_filepath = var.error_html_filepath
  # pre_js_filepath     = var.pre_js_filepath
  # random_js_filepath  = var.random_js_filepath
  # styles_css_filepath = var.styles_css_filepath
  # assets_path         = var.assets_path
  # content_version = var.content_version
}
