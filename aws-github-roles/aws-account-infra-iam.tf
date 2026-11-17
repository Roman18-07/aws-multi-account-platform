resource "aws_iam_role" "infra_github_role" {
  for_each = var.infra_github_repos_config

  provider = aws.infra

  name                 = "${each.key}-github-role"
  path                 = "/github-actions/"
  description          = "Role assumed by the GitHub OIDC provider."
  max_session_duration = 3600 # 3600 seconds = 60 minutes
  assume_role_policy   = join("", data.aws_iam_policy_document.infra_github_role[each.key].*.json)
  depends_on = [
    data.aws_iam_openid_connect_provider.github_oidc_provider
  ]
}

data "aws_iam_policy_document" "infra_github_role" {
  for_each = var.infra_github_repos_config

  provider = aws.infra

  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values = [
        "sts.amazonaws.com"
      ]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = concat(
        [
          "repo:${var.github_org_name}/${each.key}:environment:*",
          "repo:${var.github_org_name}/${each.key}:pull_request",
          "repo:${var.github_org_name}/${each.key}:ref:refs/tags/v?.?.?",
          "repo:${var.github_org_name}/${each.key}:ref:refs/heads/main",
          "repo:${var.github_org_name}/${each.key}:ref:refs/heads/hotfix"
        ],
        each.value.repo_branches
      )
    }

    principals {
      type = "Federated"
      identifiers = [
        data.aws_iam_openid_connect_provider.github_oidc_provider.arn
      ]
    }
  }
}

module "infra_attach_iam_policies" {
  for_each = var.infra_github_repos_config

  providers = {
    aws = aws.infra
  }

  source = "./modules/attach_iam_policies"

  terraform_state_prefix = var.terraform_state_prefix

  environment = "global"
  aws_region  = var.aws_region

  repo        = each.key
  iam_role    = aws_iam_role.infra_github_role[each.key].name
  permissions = each.value.permissions
}
