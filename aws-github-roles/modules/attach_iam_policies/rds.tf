resource "aws_iam_role_policy" "rds" {
  count = contains(var.permissions, "rds") ? 1 : 0

  name   = "${var.repo}-rds-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.rds.*.json, 0)
}

data "aws_iam_policy_document" "rds" {
  count = contains(var.permissions, "rds") ? 1 : 0

  statement {
    sid = "AllowAllActions"

    actions = [
      "rds:*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowRestrictedDelete"

    actions = [
      "rds:Delete*",
    ]

    resources = [
      "*"
    ]

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "aws:ResourceTag/Repo"
      values   = [var.repo]
    }
  }
}
