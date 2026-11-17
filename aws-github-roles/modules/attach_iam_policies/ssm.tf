resource "aws_iam_role_policy" "ssm" {
  count = contains(var.permissions, "ssm") ? 1 : 0

  name   = "${var.repo}-ssm-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.ssm.*.json, 0)
}

data "aws_iam_policy_document" "ssm" {
  count = contains(var.permissions, "ssm") ? 1 : 0

  statement {
    sid = "1"

    effect = "Allow"

    actions = [
      "ssm:*"
    ]

    resources = [
      "*"
    ]
  }
}
