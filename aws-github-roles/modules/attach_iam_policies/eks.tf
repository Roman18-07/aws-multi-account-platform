resource "aws_iam_role_policy" "eks" {
  count = contains(var.permissions, "eks") ? 1 : 0

  name   = "${var.repo}-eks-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.eks.*.json, 0)
}

data "aws_iam_policy_document" "eks" {
  count = contains(var.permissions, "eks") ? 1 : 0

  statement {
    sid = "AllowRead"

    actions = [
      "eks:Describe*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowAllActions"

    actions = [
      "eks:*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowRestrictedDelete"

    actions = [
      "eks:Delete*",
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
