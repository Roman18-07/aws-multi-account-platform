resource "aws_iam_role_policy" "route53" {
  count = contains(var.permissions, "route53") ? 1 : 0

  name   = "${var.repo}-route53-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.route53.*.json, 0)
}

data "aws_iam_policy_document" "route53" {
  count = contains(var.permissions, "route53") ? 1 : 0

  ### route53
  statement {
    sid    = "1"
    effect = "Allow"
    actions = [
      "route53:*"
    ]

    resources = [
      "*"
    ]
  }

  ### route53resolver
  statement {
    sid    = "2"
    effect = "Allow"
    actions = [
      "route53resolver:*"
    ]

    resources = [
      "*"
    ]
  }
}
