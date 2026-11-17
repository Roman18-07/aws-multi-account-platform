resource "aws_iam_service_linked_role" "staging_spot" {
  provider = aws.staging

  aws_service_name = "spot.amazonaws.com"
}