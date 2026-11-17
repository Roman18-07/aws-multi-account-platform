resource "aws_iam_service_linked_role" "data_science_sandbox_spot" {
  provider = aws.data-science-sandbox

  aws_service_name = "spot.amazonaws.com"
}