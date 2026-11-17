data "aws_caller_identity" "infra" {
  provider = aws.infra
}

data "aws_ssoadmin_instances" "instances" {
  provider = aws.management
}

data "aws_ssoadmin_permission_set" "staging_engineer" {
  provider = aws.management

  name         = "staging-engineer"
  instance_arn = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
}

data "aws_ssoadmin_permission_set" "prod_engineer" {
  provider = aws.management

  name         = "prod-engineer"
  instance_arn = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
}
