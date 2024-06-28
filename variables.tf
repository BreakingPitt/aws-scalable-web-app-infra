variable "cidr_block" {
  default     = "10.0.1.0"
  description = "The IP prefix to the CIDR block assigned to the VPC"
  type        = string
}


variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "s3_bucket_arn" {
  description = "The ARN of the S3 bucket for flow logs"
  type        = string
}
