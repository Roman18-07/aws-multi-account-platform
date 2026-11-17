data "aws_caller_identity" "infra" {
  provider = aws.infra
}

data "aws_iam_openid_connect_provider" "github_oidc_provider" {
  provider = aws.infra

  url = "https://token.actions.githubusercontent.com"
}
