resource "aws_iam_role_policy" "waf" {
  count = contains(var.permissions, "waf") ? 1 : 0

  name   = "${var.repo}-waf-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.waf.*.json, 0)
}

data "aws_iam_policy_document" "waf" {
  count = contains(var.permissions, "waf") ? 1 : 0

  statement {
    sid = "AllowRead"

    actions = [
      "wafv2:Describe*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowRestrictedAllActionsWithSpecificTag"

    actions = [
      "wafv2:*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowRestrictedDelete"

    actions = [
      "wafv2:Delete*",
    ]

    resources = [
      "*"
    ]
  }
}
