output "internet_gateway_id" {
  value       = aws_scalable_web_demo_internet_gateway.id
  description = "The Id of the Internet Gateway."
}


output "subnet_id" {
  value       = aws_scalable_web_demo_public_subnet.id
  description = "Subnet Id"
}


output "vpc_cidr_block" {
  value       = aws_scalable_web_demo_vpc.cidr_block
  description = "The CIDR block of the VPC."
}


output "vpc_id" {
  value       = aws_scalable_web_demo_vpc.id
  description = "VPC Id"
}
