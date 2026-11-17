resource "aws_iam_role_policy" "cur" {
  count = contains(var.permissions, "cur") ? 1 : 0

  name   = "${var.repo}-cur-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.cur.*.json, 0)
}

data "aws_iam_policy_document" "cur" {
  count = contains(var.permissions, "cur") ? 1 : 0

  statement {
    sid = "1"

    effect = "Allow"

    actions = [
      "cur:*"
    ]

    resources = [
      "*"
    ]
  }
}
