terraform {
  required_version = ">= 1.11.0"

  backend "s3" {
    bucket               = "terraform-with-actions-natalia" # CHANGE: your state bucket
    key                  = "terraform.tfstate"                     # a plain key: no workspace name here
    workspace_key_prefix = "env"                                   # each workspace gets env/<name>/terraform.tfstate
    region               = "eu-central-1"
    encrypt              = true
    use_lockfile         = true # S3 native locking: no DynamoDB table
  }
}

provider "aws" {
  region = "eu-central-1"
}

module "app_bucket" {
  source            = "../../modules/s3_bucket"
  bucket_name       = "myapp-${terraform.workspace}-bucket-natalia" # CHANGE: your initials and digits
  enable_versioning = false
  tags = {
    env = terraform.workspace
  }
}
