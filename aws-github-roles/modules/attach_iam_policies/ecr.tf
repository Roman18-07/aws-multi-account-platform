resource "aws_iam_role_policy" "ecr" {
  count = contains(var.permissions, "ecr") ? 1 : 0

  name   = "${var.repo}-ecr-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.ecr.*.json, 0)
}

data "aws_iam_policy_document" "ecr" {
  count = contains(var.permissions, "ecr") ? 1 : 0

  statement {
    sid = "1"

    actions = [
      "ecr:GetAuthorizationToken",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "2"

    actions = [
      "ecr:*"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "3"

    actions = [
      "ecr:Delete*",
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
