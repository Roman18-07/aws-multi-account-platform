resource "aws_iam_role_policy" "codebuild" {
  count = contains(var.permissions, "codebuild") ? 1 : 0

  name   = "${var.repo}-codebuild-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.codebuild.*.json, 0)
}

data "aws_iam_policy_document" "codebuild" {
  count = contains(var.permissions, "codebuild") ? 1 : 0

  statement {
    sid = "1"

    actions = [
      "codebuild:*",
    ]

    resources = [
      "*"
    ]
  }
}
