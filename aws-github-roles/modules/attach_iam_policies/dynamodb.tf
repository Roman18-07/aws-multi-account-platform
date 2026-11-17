resource "aws_iam_role_policy" "dynamodb" {
  count  = contains(var.permissions, "dynamodb") ? 1 : 0
  name   = "${var.repo}-dynamodb-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.dynamodb.*.json, 0)
}

data "aws_iam_policy_document" "dynamodb" {
  count = contains(var.permissions, "dynamodb") ? 1 : 0

  statement {
    sid = "AllowRead"
    actions = [
      "dynamodb:Describe*",
      "dynamodb:List*"
    ]
    resources = ["*"]
  }

  statement {
    sid = "AllowAllActions"
    actions = [
      "dynamodb:*"
    ]
    resources = ["*"]
  }

  statement {
    sid = "AllowRestrictedDelete"
    actions = [
      "dynamodb:Delete*"
    ]
    resources = ["*"]

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "aws:ResourceTag/Repo"
      values   = [var.repo]
    }
  }
}
