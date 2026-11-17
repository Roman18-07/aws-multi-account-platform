resource "aws_iam_role_policy_attachment" "attach-readOnly" {
  count = contains(var.permissions, "readOnly") ? 1 : 0

  role       = var.iam_role
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role_policy" "missing-readOnly" {
  count = contains(var.permissions, "readOnly") ? 1 : 0

  name   = "${var.repo}-missing-readOnly"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.readOnly.*.json, 0)
}

data "aws_iam_policy_document" "readOnly" {
  count = contains(var.permissions, "readOnly") ? 1 : 0

  statement {
    sid = "AllowMissingReadOnlyPermissions"

    actions = [
      "logs:ListTagsForResource",
      "application-autoscaling:ListTagsForResource"
    ]

    resources = [
      "*"
    ]
  }
}