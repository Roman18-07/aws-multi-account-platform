resource "aws_organizations_account" "infra" {
  email             = "aws-infra@${var.account_email_domain}"
  name              = "infra"
  parent_id         = var.root_id
  close_on_deletion = true
}

resource "aws_ssoadmin_account_assignment" "infra_admin" {
  for_each = { for idx, name in var.infra_admin_groups : name => idx }

  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.infra_admin.arn

  principal_id   = data.aws_identitystore_group.infra_admin[each.key].group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.infra.id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "infra_engineer" {
  for_each = { for idx, name in var.infra_engineer_groups : name => idx }

  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.infra_engineer.arn

  principal_id   = data.aws_identitystore_group.infra_engineer[each.key].group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.infra.id
  target_type = "AWS_ACCOUNT"
}