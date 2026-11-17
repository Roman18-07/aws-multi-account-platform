resource "aws_ssoadmin_customer_managed_policy_attachment" "staging_engineer" {
  provider = aws.management

  instance_arn       = data.aws_ssoadmin_permission_set.staging_engineer.instance_arn
  permission_set_arn = data.aws_ssoadmin_permission_set.staging_engineer.arn
  customer_managed_policy_reference {
    name = aws_iam_policy.staging_engineer.name
    path = "/"
  }
}

resource "aws_ssoadmin_customer_managed_policy_attachment" "prod_engineer" {
  provider = aws.management

  instance_arn       = data.aws_ssoadmin_permission_set.prod_engineer.instance_arn
  permission_set_arn = data.aws_ssoadmin_permission_set.prod_engineer.arn
  customer_managed_policy_reference {
    name = aws_iam_policy.prod_engineer.name
    path = "/"
  }
}
