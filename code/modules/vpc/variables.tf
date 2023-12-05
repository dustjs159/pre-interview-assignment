variable "vpc_ipv4_cidr" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_2a_ipv4_cidr" {
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2c_ipv4_cidr" {
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_2a_ipv4_cidr" {
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_2c_ipv4_cidr" {
  type        = string
  default     = "10.0.4.0/24"
}


