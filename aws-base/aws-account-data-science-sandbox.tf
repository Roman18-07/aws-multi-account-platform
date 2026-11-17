resource "aws_organizations_account" "data_science_sandbox" {
  email             = "aws-data-science-sandbox@${var.account_email_domain}"
  name              = "data-science-sandbox"
  parent_id         = var.root_id
  close_on_deletion = true
}

resource "aws_ssoadmin_account_assignment" "data_science_sandbox_admin" {
  for_each = { for idx, name in var.data_science_sandbox_admin_groups : name => idx }

  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.data_science_sandbox_admin.arn

  principal_id   = data.aws_identitystore_group.data_science_sandbox_admin[each.key].group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.data_science_sandbox.id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "data_science_sandbox_engineer" {
  for_each = { for idx, name in var.data_science_sandbox_engineer_groups : name => idx }

  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.data_science_sandbox_engineer.arn

  principal_id   = data.aws_identitystore_group.data_science_sandbox_engineer[each.key].group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.data_science_sandbox.id
  target_type = "AWS_ACCOUNT"
}