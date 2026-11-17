variable "aws_region" {
  description = "The AWS region for resources."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "The environment we are working with."
  type        = string
}

variable "permissions" {
  description = "What permissions do you need for the action?"
  type        = list(string)

  validation {
    condition = alltrue([
      for p in var.permissions : contains(["iam", "terraform", "ecr", "ecs", "eks", "ec2", "elb", "s3", "route53", "readOnly", "opensearch", "codebuild", "kms", "rds", "secretsmanager", "waf", "codeartifact", "sqs", "eventbridge", "cloudwatch", "ram", "acm", "ssm", "cloudfront", "chatbot", "sns", "cloudformation", "dms", "redshift", "firehose", "glue", "lambda", "elasticache", "cur", "athena", "securityhub", "organizations", "guardduty", "inspector2", "apigateway", "cognitoidp", "ses", "msk", "dynamodb", "cloudtrail"], p)
    ])
    error_message = "Permissions have to be in this list [\"iam\", \"terraform\", \"ecr\", \"ecs\", \"eks\", \"ec2\", \"elb\", \"s3\", \"route53\", \"readOnly\", \"opensearch\", \"codebuild\", \"kms\", \"rds\", \"secretsmanager\", \"waf\", \"codeartifact\", \"sqs\", \"eventbridge\", \"cloudwatch\", \"ram\", \"acm\", \"ssm\", \"cloudfront\",  \"chatbot\", \"sns\", \"cloudformation\", \"dms\", \"redshift\", \"firehose\", \"glue\", \"lambda\", \"elasticache\", \"cur\", \"athena\", \"securityhub\", \"organizations\", \"guardduty\", \"inspector2\", \"apigateway\", \"cognitoidp\", \"ses\", \"msk\", \"dynamodb\", \"cloudtrail\",]."
  }
}

variable "repo" {
  description = "The repo that will be using the action."
  type        = string
}

variable "iam_role" {
  description = "The IAM role id to attach the policies too."
  type        = string
}

variable "terraform_state_prefix" {
  description = "Prefix of the existing Terraform state bucket and DynamoDB lock table."
  type        = string
}
