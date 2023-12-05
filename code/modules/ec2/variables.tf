variable "vpc_id" {
  type        = string
}

variable "ec2_security_group" {
  type        = string
}

variable "public_subnet_2a" {
  type        = string
}

variable "public_subnet_2c" {
  type        = string
}

variable "private_subnet_2a" {
  type        = string
}

variable "private_subnet_2c" {
  type        = string
}

variable "ami" {
  type        = string
  default     = "ami-05068a24d083c07cd"
  description = "AMI for EC2 instance in Seoul Region. OS is Ubuntu 22.04 LTS."
}

variable "key_pair" {
  type        = string
  default     = "dev-watson"
}

