variable "environment" {
  description = "The environment we are working with."
  type        = string
}

variable "aws_region" {
  description = "The AWS region we are working with to deploy resources"
  type        = string
}

variable "github_org_name" {
  type = string
}

variable "infra_github_repos_config" {
  description = "GitHub repos config for infra account"
  type = map(object({
    repo_branches = optional(list(string), [])
    permissions   = list(string)
  }))
}

variable "management_github_repos_config" {
  description = "GitHub repos config for management account"
  type = map(object({
    permissions = list(string)
  }))
}

variable "security_github_repos_config" {
  description = "GitHub repos config for security account"
  type = map(object({
    permissions = list(string)
  }))
}

variable "shared_github_repos_config" {
  description = "GitHub repos config for shared account"
  type = map(object({
    permissions = list(string)
  }))
}

variable "staging_github_repos_config" {
  description = "GitHub repos config for staging account"
  type = map(object({
    permissions = list(string)
  }))
}

variable "prod_github_repos_config" {
  description = "GitHub repos config for prod account"
  type = map(object({
    permissions = list(string)
  }))
}

variable "data_science_sandbox_github_repos_config" {
  description = "GitHub repos config for data-science-sandbox account"
  type = map(object({
    permissions = list(string)
  }))
}

variable "account_ids" {
  description = "Target account IDs matching the six cross-account provider aliases."
  type        = map(string)
}

variable "bootstrap_repository" {
  description = "Repository name used by the bootstrap stack to name its deployment roles."
  type        = string
  default     = "aws-multi-account-platform"
}

variable "terraform_state_prefix" {
  description = "Must match the state prefix used by aws-base-accounts-init."
  type        = string
}
