########################################################################################################################
### admin
resource "aws_ssoadmin_permission_set" "management_admin" {
  name         = "management-admin"
  description  = "management-admin"
  instance_arn = tolist(data.aws_ssoadmin_instances.instances.arns)[0]

  session_duration = "PT8H"
}

resource "aws_ssoadmin_managed_policy_attachment" "management_admin" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  permission_set_arn = aws_ssoadmin_permission_set.management_admin.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "management_admin_billing" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
  permission_set_arn = aws_ssoadmin_permission_set.management_admin.arn
}

########################################################################################################################
### engineer
resource "aws_ssoadmin_permission_set" "management_engineer" {
  name         = "management-engineer"
  description  = "management-engineer"
  instance_arn = tolist(data.aws_ssoadmin_instances.instances.arns)[0]

  session_duration = "PT8H"
}

resource "aws_ssoadmin_managed_policy_attachment" "management_engineer" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.management_engineer.arn
}