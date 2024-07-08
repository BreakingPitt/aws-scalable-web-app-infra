output "autoscaling_group_name" {
  description = "The name of the Auto Scaling group."
  value = aws_autoscaling_group.example.name
}

output "elb_dns_name" {
  description = "The DNS name of the Elastic Load Balancer, which can be used to access the application."
  value = aws_elb.aws_scalable_web_demo_elastic_load_balancer.dns_name
}

output "internet_gateway_id" {
  description = "The Id of the Internet Gateway."
  value       = aws_internet_gateway.aws_scalable_web_demo_internet_gateway.id
}

output "private_subnet_id" {
  description = "Subnet Id"
  value       = aws_subnet.aws_scalable_web_demo_private_subnets[*].id
}

output "public_subnet_id" {
  description = "Subnet Id"
  value       = aws_subnet.aws_scalable_web_demo_public_subnets[*].id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC."
  value       = aws_vpc.aws_scalable_web_demo_vpc.cidr_block
}

output "vpc_id" {
  description = "VPC Id"
  value       = aws_vpc.aws_scalable_web_demo_vpc.id
}
