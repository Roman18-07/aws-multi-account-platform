resource "aws_iam_role" "shared_github_management_terraform_github_role" {
  provider = aws.shared

  name                 = "${var.github_repo_access_for}-github-role"
  path                 = "/github-actions/"
  description          = "Role assumed by the infra-github-role"
  max_session_duration = 3600 # 3600 seconds = 60 minutes
  assume_role_policy   = join("", data.aws_iam_policy_document.shared_github_management_terraform_deploy.*.json)
  depends_on = [
    aws_iam_role.infra_github_management_terraform_github_role
  ]
}

data "aws_iam_policy_document" "shared_github_management_terraform_deploy" {
  provider = aws.shared

  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:sts::${data.aws_caller_identity.infra.account_id}:assumed-role/${aws_iam_role.infra_github_management_terraform_github_role.id}/GitHubActions"
      ]
    }
  }
}

resource "aws_iam_role_policy" "shared_iam" {
  provider = aws.shared

  name   = "${var.github_repo_access_for}-iam-access"
  role   = aws_iam_role.shared_github_management_terraform_github_role.name
  policy = element(data.aws_iam_policy_document.shared_iam.*.json, 0)
}

data "aws_iam_policy_document" "shared_iam" {
  provider = aws.shared

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
