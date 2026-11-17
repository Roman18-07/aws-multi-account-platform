resource "aws_iam_role_policy" "codeartifact" {
  count = contains(var.permissions, "codeartifact") ? 1 : 0

  name   = "${var.repo}-codeartifact-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.codeartifact.*.json, 0)
}

data "aws_iam_policy_document" "codeartifact" {
  count = contains(var.permissions, "codeartifact") ? 1 : 0

  statement {
    sid = "AllowAuthAndDownload"

    actions = [
      "codeartifact:GetAuthorizationToken"
    ]

    resources = [
      "arn:aws:codeartifact:${var.aws_region}:${data.aws_caller_identity.current.account_id}:domain/*"
    ]
  }

  statement {
    sid = "AllowWriteAccessForRepository"

    actions = [
      "codeartifact:*"
    ]

    resources = [
      "arn:aws:codeartifact:${var.aws_region}:${data.aws_caller_identity.current.account_id}:repository/*"
    ]
  }

  statement {
    sid = "AllowWriteAccessForPackage"

    actions = [
      "codeartifact:*"
    ]

    resources = [
      "arn:aws:codeartifact:${var.aws_region}:${data.aws_caller_identity.current.account_id}:package/*"
    ]
  }

  statement {
    sid = "AllowServiceBearerToken"

    actions = [
      "sts:GetServiceBearerToken"
    ]

    resources = [
      "*"
    ]

    condition {
      test     = "StringEquals"
      variable = "sts:AWSServiceName"
      values   = ["codeartifact.amazonaws.com"]
    }
  }
}
