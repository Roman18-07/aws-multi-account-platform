resource "aws_iam_policy" "staging_engineer" {
  provider = aws.staging

  name = "staging-engineer"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "KafkaCluster"
        Action = [
          "kafka-cluster:Connect",
          "kafka-cluster:DescribeCluster",
          "kafka-cluster:ReadData",
          "kafka-cluster:WriteData",
          "kafka-cluster:CreateTopic",
          "kafka-cluster:AlterTopic",
          "kafka-cluster:AlterTopicDynamicConfiguration",
          "kafka-cluster:DescribeTopic",
          "kafka-cluster:DescribeTopicDynamicConfiguration",
          "kafka-cluster:DescribeTransactionalId",
          "kafka-cluster:DeleteTopic",
          "kafka-cluster:AlterGroup",
          "kafka-cluster:DescribeGroup",
          "kafka-cluster:DeleteGroup",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "GuardDutyMalwareScan"
        Action = [
          "guardduty:SendObjectMalwareScan",
          "guardduty:DescribeMalwareScans",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}