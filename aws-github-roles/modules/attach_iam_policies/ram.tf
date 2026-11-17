resource "aws_iam_role_policy" "ram" {
  count = contains(var.permissions, "ram") ? 1 : 0

  name   = "${var.repo}-ram-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.ram.*.json, 0)
}

data "aws_iam_policy_document" "ram" {
  count = contains(var.permissions, "ram") ? 1 : 0

  statement {
    sid = "1"

    actions = [
      "ram:*"
    ]

    resources = [
      "*"
    ]
  }
}
