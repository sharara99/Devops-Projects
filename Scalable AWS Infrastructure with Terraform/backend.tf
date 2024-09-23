terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.58.0"
    }
  }

  backend "s3" {
    bucket = "sharara-depi-project"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform_state"

  }

}