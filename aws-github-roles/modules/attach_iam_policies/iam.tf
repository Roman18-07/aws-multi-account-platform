resource "aws_iam_role_policy" "iam" {
  count = contains(var.permissions, "iam") ? 1 : 0

  name   = "${var.repo}-iam-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.iam.*.json, 0)
}

data "aws_iam_policy_document" "iam" {
  count = contains(var.permissions, "iam") ? 1 : 0

  statement {
    sid    = "1"
    effect = "Allow"
    actions = [
      "iam:*"
    ]

    resources = [
      "*"
    ]
  }
}
