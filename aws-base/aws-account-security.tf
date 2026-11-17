resource "aws_organizations_account" "security" {
  email             = "aws-security@${var.account_email_domain}"
  name              = "security"
  parent_id         = var.root_id
  close_on_deletion = true
}

resource "aws_ssoadmin_account_assignment" "security_admin" {
  for_each = { for idx, name in var.security_admin_groups : name => idx }

  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.security_admin.arn

  principal_id   = data.aws_identitystore_group.security_admin[each.key].group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.security.id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "security_engineer" {
  for_each = { for idx, name in var.security_engineer_groups : name => idx }

  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.security_engineer.arn

  principal_id   = data.aws_identitystore_group.security_engineer[each.key].group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.security.id
  target_type = "AWS_ACCOUNT"
}