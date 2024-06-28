resource "aws_flow_log" "aws_scalable_web_demo_vpc_flog_log" {
  log_destination      = var.s3_bucket_arn
  log_destination_type = "s3"
  traffic_type         = "ALL" 
  vpc_id               = aws_vpc.aws_scalable_web_demo_vpc.id
}

resource "aws_internet_gateway" "aws_scalable_web_demo_internet_gateway" {
  vpc_id = aws_vpc.aws_scalable_web_demo_vpc.id
}

resource "aws_route_table" "aws_scalable_web_demo_route_table" {
  vpc_id = aws_vpc.aws_scalable_web_demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_scalable_web_demo_internet_gateway.id
  }
}

resource "aws_route_table_association" "aws_scalable_web_demo_route_public_table_association" {
  count          = 3
  subnet_id      = aws_subnet.aws_scalable_web_demo_public_subnets[count.index].id
  route_table_id = aws_route_table.aws_scalable_web_demo_route_table.id
}

resource "aws_route_table_association" "aws_scalable_web_demo_route_private_table_association" {
  count          = 3
  subnet_id      = aws_subnet.aws_scalable_web_demo_private_subnets[count.index].id
  route_table_id = aws_route_table.aws_scalable_web_demo_route_table.id
}

resource "aws_security_group" "aws_scalable_web_demo_route_load_balancer_sg" {
  name        = "aws_scalable_web_demo_route_load_balancer_sg"
  description = "Allow traffic to 80 port from the Internet"
  vpc_id      = aws_vpc.aws_scalable_web_demo_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "aws_scalable_web_demo_public_subnets" {
  count                    = 3
  cidr_block               = cidrsubnet(aws_vpc.aws_scalable_web_demo_vpc.cidr_block, 4, count.index)
  availability_zone        = element(var.availability_zones, count.index)
  map_public_ip_on_launch  = true
  vpc_id                   = aws_vpc.aws_scalable_web_demo_vpc.id
}

resource "aws_subnet" "aws_scalable_web_demo_private_subnets" {
  count             = 3
  cidr_block        = cidrsubnet(aws_vpc.aws_scalable_web_demo_vpc.cidr_block, 4, count.index)
  availability_zone = element(var.availability_zones, count.index)
  vpc_id            = aws_vpc.aws_scalable_web_demo_vpc.id
}

resource "aws_vpc" "aws_scalable_web_demo_vpc" {
  cidr_block          = var.cidr_block

  enable_dns_hostnames = true
  enable_dns_support   = true

  instance_tenancy = "default"
}
