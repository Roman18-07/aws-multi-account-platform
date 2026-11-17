########################################################################################################################
### admin
resource "aws_ssoadmin_permission_set" "data_science_sandbox_admin" {
  name         = "data-science-sandbox-admin"
  description  = "data-science-sandbox-admin"
  instance_arn = tolist(data.aws_ssoadmin_instances.instances.arns)[0]

  session_duration = "PT8H"
}

resource "aws_ssoadmin_managed_policy_attachment" "data_science_sandbox_admin" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  permission_set_arn = aws_ssoadmin_permission_set.data_science_sandbox_admin.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "data_science_sandbox_admin_billing" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
  permission_set_arn = aws_ssoadmin_permission_set.data_science_sandbox_admin.arn
}

########################################################################################################################
### engineer
resource "aws_ssoadmin_permission_set" "data_science_sandbox_engineer" {
  name         = "data-science-sandbox-engineer"
  description  = "data-science-sandbox-engineer"
  instance_arn = tolist(data.aws_ssoadmin_instances.instances.arns)[0]

  session_duration = "PT8H"
}

resource "aws_ssoadmin_managed_policy_attachment" "data_science_sandbox_engineer" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.data_science_sandbox_engineer.arn
}