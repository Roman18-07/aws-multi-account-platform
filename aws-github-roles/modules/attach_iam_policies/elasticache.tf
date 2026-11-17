resource "aws_iam_role_policy" "elasticache" {
  count = contains(var.permissions, "elasticache") ? 1 : 0

  name   = "${var.repo}-elasticache-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.elasticache.*.json, 0)
}

data "aws_iam_policy_document" "elasticache" {
  count = contains(var.permissions, "elasticache") ? 1 : 0

  statement {
    sid = "AllowRead"

    actions = [
      "elasticache:Describe*",
      "elasticache:List*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowRestrictedAllActions"

    actions = [
      "elasticache:*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowRestrictedDelete"

    actions = [
      "elasticache:Delete*",
    ]

    resources = [
      "*"
    ]
  }
}