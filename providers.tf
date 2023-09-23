terraform {
  # cloud {
  #   organization = "TheDevAnt"

  #   workspaces {
  #     name = "terra-house-soul"
  #   }
  # }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "random" {
  # Configuration options
}

provider "aws" {
  # Configuration options
}