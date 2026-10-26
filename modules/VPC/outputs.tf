output "VPC_ID" {
  description = "ID of the created VPC"
  value       = aws_vpc.VPC.id
}

output "PUBLIC_SUBNET_IDS" {
  description = "IDs of public subnets"
  value       = aws_subnet.PUBLIC[*].id
}

output "PRIVATE_SUBNET_IDS" {
  description = "IDs of private subnets"
  value       = aws_subnet.PRIVATE[*].id
}

output "INTERNET_GATEWAY_ID" {
  description = "ID of the internet gateway"
  value       = aws_internet_gateway.IGW.id
}

output "NAT_GATEWAY_IDS" {
  description = "IDs of NAT gateways"
  value       = aws_nat_gateway.NAT[*].id
}