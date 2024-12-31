variable "aws_region" {
  default = "us-east-1"
  description = "AWS region for deployment"
}

variable "key_name" {
  description = "Key pair name for EC2 access"
  default = "project-cm"
}
