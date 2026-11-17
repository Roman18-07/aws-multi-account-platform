resource "aws_iam_role" "infra_github_management_terraform_github_role" {
  provider = aws.infra

  name                 = "${var.github_repo_access_for}-github-role"
  path                 = "/github-actions/"
  description          = "Role assumed by the GitHub OIDC provider."
  max_session_duration = 3600 # 3600 seconds = 60 minutes
  assume_role_policy   = join("", data.aws_iam_policy_document.infra_github_management_terraform_deploy.*.json)
  depends_on = [
    aws_iam_openid_connect_provider.this
  ]
}

data "aws_iam_policy_document" "infra_github_management_terraform_deploy" {
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
      values = [
        "repo:${var.github_org_name}/${var.github_repo_access_for}:environment:*",
        "repo:${var.github_org_name}/${var.github_repo_access_for}:pull_request",
        "repo:${var.github_org_name}/${var.github_repo_access_for}:ref:refs/heads/main",
        "repo:${var.github_org_name}/${var.github_repo_access_for}:ref:refs/heads/master",
        "repo:${var.github_org_name}/${var.github_repo_access_for}:ref:refs/tags/v?.?.?"
      ]
    }

    principals {
      type = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.this.arn
      ]
    }
  }
}

resource "aws_iam_role_policy" "infra_terraform" {
  provider = aws.infra

  name   = "${var.github_repo_access_for}-terraform-access"
  role   = aws_iam_role.infra_github_management_terraform_github_role.name
  policy = element(data.aws_iam_policy_document.infra_terraform.*.json, 0)
}

data "aws_iam_policy_document" "infra_terraform" {
  provider = aws.infra

  statement {
    sid    = "1"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.terraform_state.bucket}"
    ]
  }

  statement {
    sid    = "2"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.terraform_state.bucket}/*"
    ]
  }

  statement {
    sid    = "3"
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
    ]

    resources = [
      "arn:aws:dynamodb:*:*:table/${aws_dynamodb_table.terraform_locks.name}"
    ]
  }
}

resource "aws_iam_role_policy" "infra_iam" {
  provider = aws.infra

  name   = "${var.github_repo_access_for}-iam-access"
  role   = aws_iam_role.infra_github_management_terraform_github_role.name
  policy = element(data.aws_iam_policy_document.infra_iam.*.json, 0)
}

data "aws_iam_policy_document" "infra_iam" {
  provider = aws.infra

  statement {
    sid    = "1"
    effect = "Allow"
    actions = [
      "iam:*"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role_policy" "infra_allow_assume_role" {
  provider = aws.infra

  name   = "${var.github_repo_access_for}-assume-role-access"
  role   = aws_iam_role.infra_github_management_terraform_github_role.name
  policy = element(data.aws_iam_policy_document.infra_allow_assume_role.*.json, 0)
}

data "aws_iam_policy_document" "infra_allow_assume_role" {
  provider = aws.infra

  # https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_permissions-to-switch.html#roles-usingrole-createpolicy
  statement {
    sid    = "1"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]

    resources = [
      aws_iam_role.management_github_management_terraform_github_role.arn,
      aws_iam_role.security_github_management_terraform_github_role.arn,
      aws_iam_role.shared_github_management_terraform_github_role.arn,
      aws_iam_role.staging_github_management_terraform_github_role.arn,
      aws_iam_role.prod_github_management_terraform_github_role.arn,
      aws_iam_role.data_science_sandbox_github_management_terraform_github_role.arn
    ]
  }
}
