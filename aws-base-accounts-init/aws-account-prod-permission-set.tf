resource "aws_iam_policy" "prod_engineer" {
  provider = aws.prod

  name = "prod-engineer"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "DenySsmParametersRead"
        Effect = "Deny"
        Action = [
          "ssm:GetParameter*",
          "ssm:DescribeParameters",
        ]
        Resource = "arn:aws:ssm:*:*:parameter/*"
      },
    ]
  })
}

