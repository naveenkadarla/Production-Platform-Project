output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "vpc_arn" {
  description = "VPC ARN"
  value       = aws_vpc.this.arn
}

output "vpc_cidr" {
  description = "VPC CIDR"
  value       = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {

  description = "Public Subnet IDs"

  value = aws_subnet.public[*].id

}

output "private_subnet_ids" {

  description = "Private Subnet IDs"

  value = aws_subnet.private[*].id

}
