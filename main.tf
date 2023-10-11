terraform {
  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
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
  endpoint  = var.terratowns_endpoint
  user_uuid = var.user_uuid
  token     = var.terratowns_access_token
}

module "soul_house_hosting" {
  source               = "./modules/terrahouse_aws"
  user_uuid            = var.user_uuid
  bucket_name          = var.bucket_name
  public_path = var.soul.public_path
  pre_js_filepath      = var.pre_js_filepath
  random_js_filepath   = var.random_js_filepath
  infinity_js_filepath = var.infinity_js_filepath
  content_version      = var.content_version
}

resource "terratowns_home" "soul_house" {
  name            = "Dive In With The Soulquarians"
  description     = <<DESCRIPTION
A revolutionary rotating hip-hop/soul group, founded by inspiring producers, 
the likes of J-Dilla, Questlove, James Poyner and D'Angelo.
The name of the collective is derived from the astrology sign Aquarius,
which is the shared birth sign of the founding members of the collective.
Made up of prominent black artists of the 90s and early 2000s, such as
Q-Tip, Erykah Badu, Blackthought, Yasiin Bey, Talib Kweli, Common, Pino Palladino and Roy Hargrove.
DESCRIPTION
  domain_name     = module.soul_house_hosting.cloudfront_url
  town            = "melomaniac-mansion"
  content_version = var.soul.content_version
}

module "flags_house_hosting" {
  source               = "./modules/terrahouse_aws"
  bucket_name = "skfhsbleivjvlvbkdvbdghlol"
  user_uuid            = var.user_uuid
  public_path = var.flags.public_path
  pre_js_filepath      = var.pre_js_filepath
  random_js_filepath   = var.random_js_filepath
  infinity_js_filepath = var.infinity_js_filepath
  content_version      = var.content_version
}

resource "terratowns_home" "css_flags" {
  name            = "A Little CSS"
  description     = <<DESCRIPTION
This was the first CSS design I remember that made me so happy to figure out. Simple but at the time I felt like a genius. 
DESCRIPTION
  domain_name     = module.flags_house_hosting.cloudfront_url
  town            = "missingo"
  content_version = var.flags.content_version
}