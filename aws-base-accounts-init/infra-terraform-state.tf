resource "aws_s3_bucket" "terraform_state" {
  provider = aws.infra

  bucket = "${var.terraform_state_prefix}-terraform-state"

  # Prevent accidental deletion
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  provider = aws.infra

  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  provider = aws.infra

  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# The bucket is left open to the public by default, so lock it down here
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  provider = aws.infra

  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Used for locking the remote state so multiple people running terraform
# apply in parallel don't collide
resource "aws_dynamodb_table" "terraform_locks" {
  provider = aws.infra

  name         = "${var.terraform_state_prefix}-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
