# Based on guide here https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services
# Inspired by his module https://github.com/terraform-module/terraform-aws-github-oidc-provider
resource "aws_iam_openid_connect_provider" "this" {
  provider = aws.infra

  client_id_list = [
    "sts.amazonaws.com",
  ]

  # Refer to the README for information on obtaining the thumbprint.
  # This is specified as a variable to allow it to be updated quickly if it is
  # unexpectedly changed by GitHub.
  # See: https://github.blog/changelog/2022-01-13-github-actions-update-on-oidc-based-deployments-to-aws/
  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1",
    "1c58a3a8518e8759bf075b76b750d4f2df264fcd"
  ]
  url = "https://token.actions.githubusercontent.com"
}
