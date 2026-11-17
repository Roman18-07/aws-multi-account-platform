resource "aws_iam_role_policy" "s3" {
  count = contains(var.permissions, "s3") ? 1 : 0

  name   = "${var.repo}-s3-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.s3.*.json, 0)
}

data "aws_iam_policy_document" "s3" {
  count = contains(var.permissions, "s3") ? 1 : 0

  statement {
    sid = "1"

    effect = "Allow"

    actions = [
      "s3:*"
    ]

    resources = [
      "*"
    ]
  }
}
