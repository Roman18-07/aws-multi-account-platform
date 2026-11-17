resource "aws_iam_role_policy" "msk" {
  count = contains(var.permissions, "msk") ? 1 : 0

  name   = "${var.repo}-msk-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.msk.*.json, 0)
}

data "aws_iam_policy_document" "msk" {
  count = contains(var.permissions, "msk") ? 1 : 0

  statement {
    sid = "1"

    effect = "Allow"

    actions = [
      "kafka:*",
    ]

    resources = [
      "*"
    ]
  }
}
