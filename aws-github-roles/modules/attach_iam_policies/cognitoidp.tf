resource "aws_iam_role_policy" "cognitoidp" {
  count = contains(var.permissions, "cognitoidp") ? 1 : 0

  name   = "${var.repo}-cognitoidp-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.cognitoidp.*.json, 0)
}

data "aws_iam_policy_document" "cognitoidp" {
  count = contains(var.permissions, "cognitoidp") ? 1 : 0

  statement {
    sid = "1"

    effect = "Allow"

    actions = [
      "cognito-idp:*"
    ]

    resources = [
      "*"
    ]
  }
}
