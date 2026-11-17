resource "aws_iam_role_policy" "chatbot" {
  count = contains(var.permissions, "chatbot") ? 1 : 0

  name   = "${var.repo}-chatbot-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.chatbot.*.json, 0)
}

data "aws_iam_policy_document" "chatbot" {
  count = contains(var.permissions, "chatbot") ? 1 : 0

  statement {
    sid = "1"

    actions = [
      "chatbot:*"
    ]

    resources = [
      "*"
    ]
  }
}
