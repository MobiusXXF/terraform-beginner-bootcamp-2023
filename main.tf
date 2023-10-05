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
  endpoint = "http://localhost:4567/api"
  user_uuid = "e328f4ab-b99f-421c-84c9-4ccea042c7d1"
  token = "9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
  
}

# module "terrahouse_aws" {
#   source              = "./modules/terrahouse_aws"
#   user_uuid           = var.user_uuid
#   bucket_name         = var.bucket_name
#   index_html_filepath = var.index_html_filepath
#   error_html_filepath = var.error_html_filepath
#   pre_js_filepath     = var.pre_js_filepath
#   random_js_filepath  = var.random_js_filepath
#   styles_css_filepath = var.styles_css_filepath
#   assets_path         = var.assets_path
#   content_version     = var.content_version
# }

resource "terratowns_home" "soul_house" {
  name = "Dive In With The Soulquarians"
  description = <<DESCRIPTION
A revolutionary rotating hip-hop/soul group, founded by great producers, 
the likes of J-Dilla, Questlove, James Poyner and D'Angelo.
The name of the collective is derived from an astrology sign Aquarius,
which is the shared birth sign of the founding members of the collective.
Made up of prominent black artists of the 90s and early 200s, such as
Q-Tip, Erykah Badu, Blackthought, Yasiin Bey, Talid Kweli, Common, Pino Palladino and Roy Hargrove.

(Did you know sound travels faster underwater?)
DESCRIPTION
  # domain_name = module.terrahouse_aws.cloudfront_url 
  domain_name = "454389.cloudfront.net"  
  town = "melomaniac-mansion"
  content_version = 1
}