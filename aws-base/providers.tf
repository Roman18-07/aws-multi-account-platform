provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Source      = "managed-by-terraform"
      Repo        = "aws-multi-account-platform"
      Environment = "global"
      Application = "platform"
    }
  }
}
