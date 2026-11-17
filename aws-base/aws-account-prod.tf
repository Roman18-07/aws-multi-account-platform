resource "aws_organizations_account" "prod" {
  email             = "aws-prod@${var.account_email_domain}"
  name              = "prod"
  parent_id         = var.root_id
  close_on_deletion = true
}

resource "aws_ssoadmin_account_assignment" "prod_admin" {
  for_each = { for idx, name in var.prod_admin_groups : name => idx }

  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.prod_admin.arn

  principal_id   = data.aws_identitystore_group.prod_admin[each.key].group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.prod.id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "prod_engineer" {
  for_each = { for idx, name in var.prod_engineer_groups : name => idx }

  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.prod_engineer.arn

  principal_id   = data.aws_identitystore_group.prod_engineer[each.key].group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.prod.id
  target_type = "AWS_ACCOUNT"
}
