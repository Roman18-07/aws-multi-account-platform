resource "aws_iam_role_policy" "redshift" {
  count = contains(var.permissions, "redshift") ? 1 : 0

  name   = "${var.repo}-redshift-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.redshift.*.json, 0)
}

data "aws_iam_policy_document" "redshift" {
  count = contains(var.permissions, "redshift") ? 1 : 0

  statement {
    sid = "1"

    actions = [
      "redshift:*",
    ]

    resources = [
      "*"
    ]
  }
}
