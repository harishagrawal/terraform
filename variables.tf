variable "aws_access_key_id" {
  type        = string
  description = "AWS access key used to create infrastructure"
  sensitive = true
}

# Required
variable "aws_secret_key_id" {
  type        = string
  description = "AWS secret key used to create AWS infrastructure"
  sensitive = true
}

variable "aws_session_token" {
  type        = string
  description = "AWS session token used to create AWS infrastructure"
  default     = ""
}

variable "aws_region" {
  type        = string
  description = "AWS region used for all resources"
  default     = "us-east-1"
}

variable "default-ami" {
  type        = string
  description = "default ami to use"
  default     = "ami-0c1a7f89451184c8b"
}

variable "instance_type" {
  type        = string
  description = "default instance type"
  default     = "t2.micro"
}
