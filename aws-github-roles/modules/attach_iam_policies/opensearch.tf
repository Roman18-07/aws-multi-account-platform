resource "aws_iam_role_policy" "opensearch" {
  count = contains(var.permissions, "opensearch") ? 1 : 0

  name   = "${var.repo}-opensearch-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.opensearch.*.json, 0)
}

data "aws_iam_policy_document" "opensearch" {
  count = contains(var.permissions, "opensearch") ? 1 : 0

  statement {
    sid = "AllowRead"

    actions = [
      "es:Describe*",
      "es:List*"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowAllActions"

    actions = [
      "es:*",
    ]

    resources = [
      "*"
    ]
  }
}
