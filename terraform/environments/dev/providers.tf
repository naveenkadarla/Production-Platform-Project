provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "Production-Platform"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "Naveen"
    }
  }
}
