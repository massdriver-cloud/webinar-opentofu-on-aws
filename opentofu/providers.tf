terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~>5.0"
    }
  }

  # backend "s3" {
  #   bucket         = var.bucket_name
  #   key            = "path/to/state.tfstate"
  #   region         = var.region
  #   dynamodb_table = local.dynamodb_table_name
  # }
}

provider "aws" {
  region = var.region
}
