resource "aws_iam_role_policy" "organizations" {
  count = contains(var.permissions, "organizations") ? 1 : 0

  name   = "${var.repo}-organizations-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.organizations.*.json, 0)
}

data "aws_iam_policy_document" "organizations" {
  count = contains(var.permissions, "organizations") ? 1 : 0

  statement {
    sid = "1"

    effect = "Allow"

    actions = [
      "organizations:*"
    ]

    resources = [
      "*"
    ]
  }
}
