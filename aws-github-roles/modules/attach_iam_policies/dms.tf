resource "aws_iam_role_policy" "dms" {
  count = contains(var.permissions, "dms") ? 1 : 0

  name   = "${var.repo}-dms-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.dms.*.json, 0)
}

data "aws_iam_policy_document" "dms" {
  count = contains(var.permissions, "dms") ? 1 : 0

  statement {
    sid = "1"

    actions = [
      "dms:*"
    ]

    resources = [
      "*"
    ]
  }
}
