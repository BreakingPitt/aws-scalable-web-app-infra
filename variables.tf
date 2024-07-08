variable "ami_id" {
  default     = data.aws_ami.amazon_linux_2.id
  description = "The AMI ID to use for the EC2 instances"
  type        = string
}

variable "availability_zones" {
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  description = "List of availability zones."
  type        = list(string)
}

variable "cidr_block" {
  default     = "10.0.1.0"
  description = "The IP prefix to the CIDR block assigned to the VPC."
  type        = string
}

variable "instance_type" {
  default     = "t2.micro"
  description = "The instance type to use."
  type        = string
}

variable "s3_bucket_name" {
  default     = "aws_scalable_web_demo_s3_flow_logs"
  description = "The name  of the S3 bucket for flow logs."
  type        = string
}


variable "key_name" {
  default     = "aws_scalable_web_demo_key_pair"
  description = "The name of the SSH key pair"
  type        = string
}

variable "public_key" {
  default      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0sU8/2O6wr2kH0DFG7FskniLxeAMhpTUL9w7dI5zN1k6shfj7B3GJd0Vh2zz4EBH/Z4BhfhbY7yzBn9Hie3HF/rDF7s+E7yB5Er3g8xxKwpS6/y5N5lF/BpZ0o1kK0/Y7T+uBOF+5sv5yqE6bdjKQ1BqUnML+v8SxjMzU9cfFmvYfHfUZTxDj5zskzyq8jIByBh5aFB1D5rK8+7dfghIUsHBCBPLZa6HP+6fskiWxyhrFOhUo9+nlT5cAXJxKpKjl7aO8RZxdGjp8Lhxh4eRyFg7Q9vEj3HRY0R6VLBzvxZ4fS9vWvH75v1t5tGydfDH+2GzxFfsN6yPs5L2Z8r8ZkX placeholder-key"
  description = "The public key material for the SSH key pair"
  type        = string
}
