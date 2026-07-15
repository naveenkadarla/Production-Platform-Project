terraform {
  backend "s3" {
    bucket         = "production-platform-115569561822-tfstate"
    key            = "bootstrap/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "production-platform-locks"
    encrypt        = true
  }
}
