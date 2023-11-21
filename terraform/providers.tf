terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.26.0"
    }
  }

    required_version = ">= 0.14.9"
}

provider "aws" {
  region                      = "ap-southeast-2"
  shared_credentials_files    = ["~/.aws/credentials"]
  profile                     = "default"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    autoscaling    = "http://localhost:4566"
    cloudwatch     = "http://localhost:4566"
    ec2            = "http://localhost:4566"
    iam            = "http://localhost:4566"
    s3             = "http://localhost:4566"
    sts            = "http://localhost:4566"
    eks            = "http://localhost:4566"
  }
}