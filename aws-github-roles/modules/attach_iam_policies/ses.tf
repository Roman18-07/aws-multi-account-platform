resource "aws_iam_role_policy" "ses" {
  count = contains(var.permissions, "ses") ? 1 : 0

  name   = "${var.repo}-ses-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.ses.*.json, 0)
}

data "aws_iam_policy_document" "ses" {
  count = contains(var.permissions, "ses") ? 1 : 0

  statement {
    sid    = "1"
    effect = "Allow"
    actions = [
      "ses:*"
    ]

    resources = [
      "*"
    ]
  }
}
