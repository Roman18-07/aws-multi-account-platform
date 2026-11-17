resource "aws_organizations_organization" "org" {
  aws_service_access_principals = [
    "sso.amazonaws.com",
    "account.amazonaws.com",
    "cost-optimization-hub.bcm.amazonaws.com",
    "iam.amazonaws.com",
    "cloudtrail.amazonaws.com",
    "guardduty.amazonaws.com",
    "securityhub.amazonaws.com"
  ]

  feature_set = "ALL"
}
