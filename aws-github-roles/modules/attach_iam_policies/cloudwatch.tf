resource "aws_iam_role_policy" "cloudwatch" {
  count = contains(var.permissions, "cloudwatch") ? 1 : 0

  name   = "${var.repo}-cloudwatch-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.cloudwatch.*.json, 0)
}

data "aws_iam_policy_document" "cloudwatch" {
  count = contains(var.permissions, "cloudwatch") ? 1 : 0

  statement {
    sid = "1"

    actions = [
      "cloudwatch:*"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "2"

    actions = [
      "logs:*"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "3"

    actions = [
      "cloudwatch:Delete*",
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

  statement {
    sid = "4"

    actions = [
      "logs:Delete*",
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
