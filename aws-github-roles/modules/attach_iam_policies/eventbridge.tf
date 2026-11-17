resource "aws_iam_role_policy" "eventbridge" {
  count = contains(var.permissions, "eventbridge") ? 1 : 0

  name   = "${var.repo}-eventbridge-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.eventbridge.*.json, 0)
}

data "aws_iam_policy_document" "eventbridge" {
  count = contains(var.permissions, "eventbridge") ? 1 : 0

  statement {
    sid = "AllowRead"

    actions = [
      "events:Describe*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowAllActions"

    actions = [
      "events:*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowRestrictedDelete"

    actions = [
      "events:Delete*",
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
