resource "aws_organizations_account" "shared" {
  email             = "aws-shared@${var.account_email_domain}"
  name              = "shared"
  parent_id         = var.root_id
  close_on_deletion = true
}

resource "aws_ssoadmin_account_assignment" "shared_admin" {
  for_each = { for idx, name in var.shared_admin_groups : name => idx }

  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.shared_admin.arn

  principal_id   = data.aws_identitystore_group.shared_admin[each.key].group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.shared.id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "shared_engineer" {
  for_each = { for idx, name in var.shared_engineer_groups : name => idx }

  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.shared_engineer.arn

  principal_id   = data.aws_identitystore_group.shared_engineer[each.key].group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.shared.id
  target_type = "AWS_ACCOUNT"
}
