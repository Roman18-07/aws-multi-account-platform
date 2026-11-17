variable "environment" {
  description = "The environment for which resources will be deployed. e.g. staging, prod"
  type        = string
}

variable "aws_region" {
  description = "The AWS region we are working with to deploy resources"
  type        = string
}

variable "github_org_name" {
  type = string
}

variable "github_repo_access_for" {
  type = string
}

variable "terraform_state_prefix" {
  type = string
}

variable "account_profiles" {
  description = "Local AWS profile names for each original provider alias."
  type        = map(string)
}
