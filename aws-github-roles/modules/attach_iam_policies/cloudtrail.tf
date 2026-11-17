resource "aws_iam_role_policy" "cloudtrail" {
  count = contains(var.permissions, "cloudtrail") ? 1 : 0

  name   = "${var.repo}-cloudtrail-access"
  role   = var.iam_role
  policy = element(data.aws_iam_policy_document.cloudtrail.*.json, 0)
}

data "aws_iam_policy_document" "cloudtrail" {
  count = contains(var.permissions, "cloudtrail") ? 1 : 0

  statement {
    sid = "CloudTrailAdminNoDelete"

    actions = [
      "cloudtrail:CreateTrail",
      "cloudtrail:UpdateTrail",
      "cloudtrail:StartLogging",
      "cloudtrail:StopLogging",
      "cloudtrail:PutEventSelectors",
      "cloudtrail:GetEventSelectors",
      "cloudtrail:GetTrailStatus",
      "cloudtrail:ListTrails",
      "cloudtrail:ListTags",
      "cloudtrail:AddTags",
      "cloudtrail:RemoveTags",
      "cloudtrail:DescribeTrails",
      "cloudtrail:PutInsightSelectors",
      "cloudtrail:GetInsightSelectors"
    ]

    resources = ["*"]
  }

  statement {
    sid = "CloudTrailDeleteScoped"

    actions   = ["cloudtrail:DeleteTrail"]
    resources = ["*"]

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "aws:ResourceTag/Repo"
      values   = [var.repo]
    }
  }
}
