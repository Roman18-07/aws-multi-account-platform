resource "aws_iam_role_policy" "securityhub" {
  count = contains(var.permissions, "securityhub") ? 1 : 0

  name   = "${var.repo}-securityhub-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.securityhub.*.json, 0)
}

data "aws_iam_policy_document" "securityhub" {
  count = contains(var.permissions, "securityhub") ? 1 : 0

  statement {
    sid = "1"

    effect = "Allow"

    actions = [
      "securityhub:*"
    ]

    resources = [
      "*"
    ]
  }
}
