# Input Variables

# AWS Region

variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-1"
}

# s3 bucket A
variable "s3-bucket-a" {
  description = "The name of the S3 bucket A"  
  type = string  
}

# s3 bucket B

variable "s3-bucket-b" {
  description = "The name of the S3 bucket B"
  type = string
}