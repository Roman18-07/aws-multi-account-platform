resource "aws_iam_role_policy" "cloudformation" {
  count = contains(var.permissions, "cloudformation") ? 1 : 0

  name   = "${var.repo}-cloudformation-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.cloudformation.*.json, 0)
}

data "aws_iam_policy_document" "cloudformation" {
  count = contains(var.permissions, "cloudformation") ? 1 : 0

  statement {
    sid = "1"

    actions = [
      "cloudformation:*"
    ]

    resources = [
      "*"
    ]
  }
}
