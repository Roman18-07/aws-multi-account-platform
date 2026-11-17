resource "aws_iam_role" "management_github_role" {
  for_each = var.management_github_repos_config

  provider = aws.management

  name                 = "${each.key}-github-role"
  path                 = "/github-actions/"
  description          = "Role assumed by the relative role from infra"
  max_session_duration = 3600 # 3600 seconds = 60 minutes
  assume_role_policy   = join("", data.aws_iam_policy_document.management_github_role[each.key].*.json)
  depends_on = [
    aws_iam_role.infra_github_role
  ]
}

data "aws_iam_policy_document" "management_github_role" {
  for_each = var.management_github_repos_config

  provider = aws.management

  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:sts::${data.aws_caller_identity.infra.account_id}:assumed-role/${aws_iam_role.infra_github_role[each.key].id}/GitHubActions"
      ]
    }
  }
}

module "management_attach_iam_policies" {
  for_each = var.management_github_repos_config

  providers = {
    aws = aws.management
  }

  source = "./modules/attach_iam_policies"

  terraform_state_prefix = var.terraform_state_prefix

  environment = "management"
  aws_region  = var.aws_region

  repo        = each.key
  iam_role    = aws_iam_role.management_github_role[each.key].name
  permissions = each.value.permissions
}

### Allow assume for this role from infra management
data "aws_iam_policy_document" "infra_for_management_allow_assume_role" {
  for_each = var.management_github_repos_config

  provider = aws.infra

  # https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_permissions-to-switch.html#roles-usingrole-createpolicy
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]

    resources = [
      aws_iam_role.management_github_role[each.key].arn
    ]
  }
}

resource "aws_iam_role_policy" "infra_for_management_allow_assume_role" {
  for_each = var.management_github_repos_config

  provider = aws.infra

  name   = "${each.key}-management-assume-role-access"
  role   = aws_iam_role.infra_github_role[each.key].name
  policy = element(data.aws_iam_policy_document.infra_for_management_allow_assume_role[each.key].*.json, 0)
}
