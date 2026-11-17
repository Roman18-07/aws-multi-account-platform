resource "aws_iam_role_policy" "sqs" {
  count = contains(var.permissions, "sqs") ? 1 : 0

  name   = "${var.repo}-sqs-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.sqs.*.json, 0)
}

data "aws_iam_policy_document" "sqs" {
  count = contains(var.permissions, "sqs") ? 1 : 0

  statement {
    sid = "AllowRead"

    actions = [
      "sqs:Describe*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowAllActions"

    actions = [
      "sqs:*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowRestrictedDelete"

    actions = [
      "sqs:Delete*",
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
