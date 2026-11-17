resource "aws_iam_role_policy" "inspector2" {
  count = contains(var.permissions, "inspector2") ? 1 : 0

  name   = "${var.repo}-inspector2-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.inspector2.*.json, 0)
}

data "aws_iam_policy_document" "inspector2" {
  count = contains(var.permissions, "inspector2") ? 1 : 0

  statement {
    sid = "1"

    effect = "Allow"

    actions = [
      "inspector2:*"
    ]

    resources = [
      "*"
    ]
  }
}
