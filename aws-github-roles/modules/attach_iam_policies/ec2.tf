resource "aws_iam_role_policy" "ec2" {
  count = contains(var.permissions, "ec2") ? 1 : 0

  name   = "${var.repo}-ec2-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.ec2.*.json, 0)
}

data "aws_iam_policy_document" "ec2" {
  count = contains(var.permissions, "ec2") ? 1 : 0

  statement {
    sid = "AllowRead"

    actions = [
      "ec2:Describe*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowAllActions"

    actions = [
      "ec2:*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowRestrictedDelete"

    actions = [
      "ec2:Delete*",
    ]

    resources = [
      "*"
    ]

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "ec2:ResourceTag/Repo"
      values   = [var.repo]
    }
  }
}
