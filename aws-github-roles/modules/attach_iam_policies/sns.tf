resource "aws_iam_role_policy" "sns" {
  count = contains(var.permissions, "sns") ? 1 : 0

  name   = "${var.repo}-sns-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.sns.*.json, 0)
}

data "aws_iam_policy_document" "sns" {
  count = contains(var.permissions, "sns") ? 1 : 0

  statement {
    sid = "AllowRead"

    actions = [
      "sns:Get*",
      "sns:List*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowAllActions"

    actions = [
      "sns:*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowRestrictedDelete"

    actions = [
      "sns:Delete*",
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
