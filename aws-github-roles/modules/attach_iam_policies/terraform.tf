resource "aws_iam_role_policy" "terraform" {
  count = contains(var.permissions, "terraform") ? 1 : 0

  name   = "${var.repo}-terraform-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.terraform.*.json, 0)
}

data "aws_iam_policy_document" "terraform" {
  count = contains(var.permissions, "terraform") ? 1 : 0

  statement {
    sid    = "1"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${var.terraform_state_prefix}-terraform-state"
    ]
  }

  statement {
    sid    = "2"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::${var.terraform_state_prefix}-terraform-state/*"
    ]
  }

  statement {
    sid    = "3"
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
    ]

    resources = [
      "arn:aws:dynamodb:*:*:table/${var.terraform_state_prefix}-terraform-locks"
    ]
  }
}
