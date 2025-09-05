variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "Ubuntu AMI ID"
  default     = "ami-0c55b159cbfafe1f0" # Ubuntu 20.04 in us-east-1
}

variable "key_name" {
  description = "EC2 Key Pair Name"
}
