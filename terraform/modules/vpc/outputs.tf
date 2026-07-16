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

output "internet_gateway_id" {

  description = "Internet Gateway ID"

  value = aws_internet_gateway.this.id

}

output "nat_gateway_id" {

  description = "NAT Gateway ID"

  value = aws_nat_gateway.this.id

}

output "nat_gateway_public_ip" {

  description = "Elastic IP of NAT Gateway"

  value = aws_eip.nat.public_ip

}
output "public_route_table_id" {

  description = "Public Route Table ID"

  value = aws_route_table.public.id

}

output "private_route_table_id" {

  description = "Private Route Table ID"

  value = aws_route_table.private.id

}
output "bastion_security_group_id" {
  value = aws_security_group.bastion.id
}

output "eks_cluster_security_group_id" {
  value = aws_security_group.eks_cluster.id
}

output "eks_nodes_security_group_id" {
  value = aws_security_group.eks_nodes.id
}

