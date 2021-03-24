terraform {
  required_version = "= 0.14.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.21"
    }

  }
}

provider "aws" {
  region = "ca-central-1"
}
