resource "aws_flow_log" "aws_scalable_web_demo_vpc_flog_log" {
  log_destination      = aws_s3_bucket.aws_scalable_web_demo_s3_bucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL" 
  vpc_id               = aws_vpc.aws_scalable_web_demo_vpc.id
}

resource "aws_internet_gateway" "aws_scalable_web_demo_internet_gateway" {
  vpc_id = aws_vpc.aws_scalable_web_demo_vpc.id
}

resource "aws_kms_alias" "s3_kms_key_alias" {
  name          = "alias/aws-scalable-web-demo-kms-key-1"
  target_key_id = aws_kms_key.aws_scalable_web_demo_kms_key.id
}

resource "aws_kms_key" "aws_scalable_web_demo_kms_key" {
  description             = "KMS key for S3 server-side encryption"
  deletion_window_in_days = 30
}

resource "aws_kms_key_policy" "aws_scalable_web_demo_kms_key_policy" {
  key_id = aws_kms_key.aws_scalable_web_demo_kms_key.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "aws-scalable-web-demo-kms-key-1",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
EOF
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

resource "aws_s3_bucket" "aws_scalable_web_demo_s3_bucket" {
  bucket = var.s3_bucket_name

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "aws_scalable_web_demo_s3_bucket_ownership_controls" {
  bucket = aws_s3_bucket.aws_scalable_web_demo_s3_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_versioning" "aws_scalable_web_demo_s3_bucket_versioning" {
  bucket = aws_s3_bucket.aws_scalable_web_demo_s3_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "aws_scalable_web_demo_s3_bucket_logging" {
  bucket = aws_s3_bucket.aws_scalable_web_demo_s3_bucket.id

  target_bucket = aws_s3_bucket.aws_scalable_web_demo_s3_bucket.id
  target_prefix = "log/"
}

resource "aws_security_group" "aws_scalable_web_demo_route_load_balancer_sg" {
  name        = "aws_scalable_web_demo_route_load_balancer_sg"
  description = "Allow traffic to 80 port from the Internet"
  vpc_id      = aws_vpc.aws_scalable_web_demo_vpc.id

  ingress {
    description = "Allow inbound HTTP traffic from allowed IPs."
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["92.172.63.196/32"]
  }

  egress {
    description = "Allow outbound traffic."
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
