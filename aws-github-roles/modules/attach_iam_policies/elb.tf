resource "aws_iam_role_policy" "elb" {
  count = contains(var.permissions, "elb") ? 1 : 0

  name   = "${var.repo}-elb-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.elb.*.json, 0)
}

data "aws_iam_policy_document" "elb" {
  count = contains(var.permissions, "elb") ? 1 : 0

  statement {
    sid = "AllowRead"

    actions = [
      "elasticloadbalancing:Describe*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowAllActions"

    actions = [
      "elasticloadbalancing:*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowRestrictedDelete"

    actions = [
      "elasticloadbalancing:Delete*",
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
