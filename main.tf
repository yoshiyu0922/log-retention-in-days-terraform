terraform {
  required_version = ">=1.3.7"
  backend "s3" {
    bucket = "bulk-change-log-retention-in-days-terraform"
    region = "ap-northeast-1"
    key    = "path/platform.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

module "platform" {
  source = "./modules"
}
