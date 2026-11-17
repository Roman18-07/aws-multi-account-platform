resource "aws_iam_role_policy" "firehose" {
  count = contains(var.permissions, "firehose") ? 1 : 0

  name   = "${var.repo}-firehose-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.firehose.*.json, 0)
}

data "aws_iam_policy_document" "firehose" {
  count = contains(var.permissions, "firehose") ? 1 : 0

  statement {
    sid = "AllowRead"

    actions = [
      "firehose:Describe*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowAllActions"

    actions = [
      "firehose:*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowRestrictedDelete"

    actions = [
      "firehose:Delete*",
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
