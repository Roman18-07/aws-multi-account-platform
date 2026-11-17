resource "aws_iam_role_policy" "ecs" {
  count = contains(var.permissions, "ecs") ? 1 : 0

  name   = "${var.repo}-ecs-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.ecs.*.json, 0)
}

data "aws_iam_policy_document" "ecs" {
  count = contains(var.permissions, "ecs") ? 1 : 0

  statement {
    sid = "AllowAll"

    actions = [
      "ecs:*",
    ]

    resources = [
      "*"
    ]
  }
}
