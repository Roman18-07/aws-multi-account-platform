resource "aws_iam_role_policy" "lambda" {
  count = contains(var.permissions, "lambda") ? 1 : 0

  name   = "${var.repo}-lambda-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.lambda.*.json, 0)
}

data "aws_iam_policy_document" "lambda" {
  count = contains(var.permissions, "lambda") ? 1 : 0

  statement {
    sid = "1"

    effect = "Allow"

    actions = [
      "lambda:*"
    ]

    resources = [
      "*"
    ]
  }
}