resource "aws_iam_role_policy" "acm" {
  count = contains(var.permissions, "acm") ? 1 : 0

  name   = "${var.repo}-acm-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.acm.*.json, 0)
}

data "aws_iam_policy_document" "acm" {
  count = contains(var.permissions, "acm") ? 1 : 0

  statement {
    sid = "1"

    actions = [
      "acm:*"
    ]

    resources = [
      "*"
    ]
  }
}
