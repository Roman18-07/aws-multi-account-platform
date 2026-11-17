resource "aws_iam_role_policy" "apigateway" {
  count = contains(var.permissions, "apigateway") ? 1 : 0

  name   = "${var.repo}-apigateway-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.apigateway.*.json, 0)
}

data "aws_iam_policy_document" "apigateway" {
  count = contains(var.permissions, "apigateway") ? 1 : 0

  statement {
    sid = "1"

    effect = "Allow"

    actions = [
      "apigateway:*"
    ]

    resources = [
      "*"
    ]
  }
}
