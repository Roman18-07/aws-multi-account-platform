resource "aws_iam_role_policy" "guardduty" {
  count = contains(var.permissions, "guardduty") ? 1 : 0

  name   = "${var.repo}-guardduty-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.guardduty.*.json, 0)
}

data "aws_iam_policy_document" "guardduty" {
  count = contains(var.permissions, "guardduty") ? 1 : 0

  statement {
    sid = "1"

    effect = "Allow"

    actions = [
      "guardduty:*"
    ]

    resources = [
      "*"
    ]
  }
}
