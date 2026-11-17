variable "environment" {
  description = "The environment for which resources will be deployed. e.g. staging, prod"
  type        = string
}

variable "aws_region" {
  description = "The AWS region we are working with to deploy resources"
  type        = string
}

variable "root_id" {
  type = string
}

variable "budget_notification_email" {
  type = string
}

variable "budget_main_monthly_cost_alarm" {
  type = string
}

variable "infra_admin_groups" {
  type = list(string)
}

variable "infra_engineer_groups" {
  type = list(string)
}

variable "management_admin_groups" {
  type = list(string)
}

variable "management_engineer_groups" {
  type = list(string)
}

variable "security_admin_groups" {
  type = list(string)
}

variable "security_engineer_groups" {
  type = list(string)
}

variable "shared_admin_groups" {
  type = list(string)
}

variable "shared_engineer_groups" {
  type = list(string)
}

variable "staging_admin_groups" {
  type = list(string)
}

variable "staging_engineer_groups" {
  type = list(string)
}

variable "prod_admin_groups" {
  type = list(string)
}

variable "prod_engineer_groups" {
  type = list(string)
}

variable "data_science_sandbox_admin_groups" {
  type = list(string)
}

variable "data_science_sandbox_engineer_groups" {
  type = list(string)
}
variable "account_email_domain" {
  description = "Domain for the seven unique account email addresses. Replace the example with a domain you control."
  type        = string
}
