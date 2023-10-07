terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  cloud {
    organization = "TheDevAnt"

    workspaces {
      name = "terra-house-soul"
    }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.user_uuid
  token = var.terratowns_access_token
}

module "terrahouse_aws" {
  source              = "./modules/terrahouse_aws"
  user_uuid           = var.user_uuid
  bucket_name         = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  pre_js_filepath     = var.pre_js_filepath
  random_js_filepath  = var.random_js_filepath
  styles_css_filepath = var.styles_css_filepath
  assets_path         = var.assets_path
  content_version     = var.content_version
}

resource "terratowns_home" "soul_house" {
  name = "Dive In With The Soulquarians"
  description = <<DESCRIPTION
A revolutionary rotating hip-hop/soul group, founded by inspiring producers, 
the likes of J-Dilla, Questlove, James Poyner and D'Angelo.
The name of the collective is derived from the astrology sign Aquarius,
which is the shared birth sign of the founding members of the collective.
Made up of prominent black artists of the 90s and early 2000s, such as
Q-Tip, Erykah Badu, Blackthought, Yasiin Bey, Talib Kweli, Common, Pino Palladino and Roy Hargrove.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  town = "melomaniac-mansion"
  content_version = 2
}