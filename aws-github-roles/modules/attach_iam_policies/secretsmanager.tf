data "aws_caller_identity" "current" {}

resource "aws_iam_role_policy" "secretsmanager" {
  count = contains(var.permissions, "secretsmanager") ? 1 : 0

  name   = "${var.repo}-secretsmanager-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.secretsmanager.*.json, 0)
}

data "aws_iam_policy_document" "secretsmanager" {
  count = contains(var.permissions, "secretsmanager") ? 1 : 0

  statement {
    sid = "1"

    actions = [
      "secretsmanager:*"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "2"

    actions = [
      "secretsmanager:*"
    ]

    resources = [
      "arn:aws:secretsmanager:*:${data.aws_caller_identity.current.account_id}:secret:*"
    ]
  }
}
