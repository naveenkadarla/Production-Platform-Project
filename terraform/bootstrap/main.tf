##################################################
# Terraform State S3 Bucket
##################################################

resource "aws_s3_bucket" "terraform_state" {

  bucket = var.bucket_name

  force_destroy = false

  tags = {
    Name = var.bucket_name
  }

}

##################################################
# Enable Versioning
##################################################

resource "aws_s3_bucket_versioning" "terraform_state" {

  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {

    status = "Enabled"

  }

}

##################################################
# Enable Encryption
##################################################

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {

  bucket = aws_s3_bucket.terraform_state.id

  rule {

    apply_server_side_encryption_by_default {

      sse_algorithm = "AES256"

    }

  }

}

##################################################
# Block Public Access
##################################################

resource "aws_s3_bucket_public_access_block" "terraform_state" {

  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

##################################################
# Bucket Ownership
##################################################

resource "aws_s3_bucket_ownership_controls" "terraform_state" {

  bucket = aws_s3_bucket.terraform_state.id

  rule {

    object_ownership = "BucketOwnerEnforced"

  }

}

##################################################
# Lifecycle Configuration
##################################################

resource "aws_s3_bucket_lifecycle_configuration" "terraform_state" {

  depends_on = [
    aws_s3_bucket_versioning.terraform_state
  ]

  bucket = aws_s3_bucket.terraform_state.id

  rule {

    id = "terraform-state"

    status = "Enabled"

    filter {}

    noncurrent_version_expiration {

      noncurrent_days = 90

    }

  }

}

##################################################
# DynamoDB Lock Table
##################################################

resource "aws_dynamodb_table" "terraform_lock" {

  name = var.dynamodb_table

  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {

    name = "LockID"

    type = "S"

  }

  point_in_time_recovery {

    enabled = true

  }

  tags = {

    Name = var.dynamodb_table

  }

}
