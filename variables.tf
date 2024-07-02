variable "availability_zones" {
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  description = "List of availability zones"
  type        = list(string)
}

variable "cidr_block" {
  default     = "10.0.1.0"
  description = "The IP prefix to the CIDR block assigned to the VPC"
  type        = string
}

variable "s3_bucket_name" {
  default     = "aws_scalable_web_demo_s3_flow_logs"
  description = "The name  of the S3 bucket for flow logs"
  type        = string
}
