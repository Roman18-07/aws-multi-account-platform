resource "aws_organizations_account" "staging" {
  email             = "aws-staging@${var.account_email_domain}"
  name              = "staging"
  parent_id         = var.root_id
  close_on_deletion = true
}

resource "aws_ssoadmin_account_assignment" "staging_admin" {
  for_each = { for idx, name in var.staging_admin_groups : name => idx }

  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.staging_admin.arn

  principal_id   = data.aws_identitystore_group.staging_admin[each.key].group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.staging.id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "staging_engineer" {
  for_each = { for idx, name in var.staging_engineer_groups : name => idx }

  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.staging_engineer.arn

  principal_id   = data.aws_identitystore_group.staging_engineer[each.key].group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.staging.id
  target_type = "AWS_ACCOUNT"
}