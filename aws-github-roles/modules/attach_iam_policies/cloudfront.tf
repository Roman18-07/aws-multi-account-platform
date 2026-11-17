resource "aws_iam_role_policy" "cloudfront" {
  count = contains(var.permissions, "cloudfront") ? 1 : 0

  name   = "${var.repo}-cloudfront-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.cloudfront.*.json, 0)
}

data "aws_iam_policy_document" "cloudfront" {
  count = contains(var.permissions, "cloudfront") ? 1 : 0

  statement {
    sid = "1"

    actions = [
      "cloudfront:*"
    ]

    resources = [
      "*"
    ]
  }
}
