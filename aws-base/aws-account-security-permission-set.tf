########################################################################################################################
### admin
resource "aws_ssoadmin_permission_set" "security_admin" {
  name         = "security-admin"
  description  = "security-admin"
  instance_arn = tolist(data.aws_ssoadmin_instances.instances.arns)[0]

  session_duration = "PT8H"
}

resource "aws_ssoadmin_managed_policy_attachment" "security_admin" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  permission_set_arn = aws_ssoadmin_permission_set.security_admin.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "security_admin_billing" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
  permission_set_arn = aws_ssoadmin_permission_set.security_admin.arn
}

########################################################################################################################
### engineer
resource "aws_ssoadmin_permission_set" "security_engineer" {
  name         = "security-engineer"
  description  = "security-engineer"
  instance_arn = tolist(data.aws_ssoadmin_instances.instances.arns)[0]

  session_duration = "PT8H"
}

resource "aws_ssoadmin_managed_policy_attachment" "security_engineer" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.security_admin.arn
}