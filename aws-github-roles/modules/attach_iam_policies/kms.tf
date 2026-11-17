resource "aws_iam_role_policy" "kms" {
  count = contains(var.permissions, "kms") ? 1 : 0

  name   = "${var.repo}-kms-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.kms.*.json, 0)
}

data "aws_iam_policy_document" "kms" {
  count = contains(var.permissions, "kms") ? 1 : 0

  statement {
    sid = "AllowAllActions"

    actions = [
      "kms:*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowRestrictedDelete"

    actions = [
      "kms:Delete*",
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
