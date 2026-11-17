########################################################################################################################
### admin
resource "aws_ssoadmin_permission_set" "staging_admin" {
  name         = "staging-admin"
  description  = "staging-admin"
  instance_arn = tolist(data.aws_ssoadmin_instances.instances.arns)[0]

  session_duration = "PT8H"
}

resource "aws_ssoadmin_managed_policy_attachment" "staging_admin" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  permission_set_arn = aws_ssoadmin_permission_set.staging_admin.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "staging_admin_billing" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
  permission_set_arn = aws_ssoadmin_permission_set.staging_admin.arn
}

########################################################################################################################
### engineer
resource "aws_ssoadmin_permission_set" "staging_engineer" {
  name         = "staging-engineer"
  description  = "staging-engineer"
  instance_arn = tolist(data.aws_ssoadmin_instances.instances.arns)[0]

  session_duration = "PT8H"
}

resource "aws_ssoadmin_managed_policy_attachment" "staging_engineer" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.staging_engineer.arn
}