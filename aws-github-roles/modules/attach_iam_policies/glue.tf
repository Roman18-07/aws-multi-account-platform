resource "aws_iam_role_policy" "glue" {
  count = contains(var.permissions, "glue") ? 1 : 0

  name   = "${var.repo}-glue-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.glue.*.json, 0)
}

data "aws_iam_policy_document" "glue" {
  count = contains(var.permissions, "glue") ? 1 : 0

  statement {
    sid = "AllowRead"

    actions = [
      "glue:Get*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowRestrictedAllActionsWithSpecificTag"

    actions = [
      "glue:*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowRestrictedDelete"

    actions = [
      "glue:Delete*",
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