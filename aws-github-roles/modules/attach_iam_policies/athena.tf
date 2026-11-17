resource "aws_iam_role_policy" "athena" {
  count = contains(var.permissions, "athena") ? 1 : 0

  name   = "${var.repo}-athena-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.athena.*.json, 0)
}

data "aws_iam_policy_document" "athena" {
  count = contains(var.permissions, "athena") ? 1 : 0

  statement {
    sid = "1"

    effect = "Allow"

    actions = [
      "athena:*"
    ]

    resources = [
      "*"
    ]
  }
}
