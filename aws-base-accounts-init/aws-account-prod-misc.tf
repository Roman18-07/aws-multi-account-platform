resource "aws_iam_service_linked_role" "prod_spot" {
  provider = aws.prod

  aws_service_name = "spot.amazonaws.com"
}