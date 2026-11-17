resource "aws_organizations_account" "management" {
  email             = "aws-multi-account-platform@${var.account_email_domain}"
  name              = "management"
  parent_id         = var.root_id
  close_on_deletion = true
}

resource "aws_ssoadmin_account_assignment" "management_admin" {
  for_each = { for idx, name in var.management_admin_groups : name => idx }

  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.management_admin.arn

  principal_id   = data.aws_identitystore_group.management_admin[each.key].group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.management.id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "management_engineer" {
  for_each = { for idx, name in var.management_engineer_groups : name => idx }

  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.management_engineer.arn

  principal_id   = data.aws_identitystore_group.management_engineer[each.key].group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.management.id
  target_type = "AWS_ACCOUNT"
}
