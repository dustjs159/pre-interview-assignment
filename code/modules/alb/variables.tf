variable "vpc_id" {
  type        = string
}

variable "alb_security_group" {
  type        = string
}

variable "public_subnet_2a" {
  type        = string
}

variable "public_subnet_2c" {
  type        = string
}

variable "alb_ssl_policy" {
  type        = string
  default     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
}

variable "acm_arm" {
  type        = string
  default     = "" # acm arn 
}

variable "alb_listener_host_header" {
  type        = string
  default     = "" # public domain
}

variable "target_instance_id" {
  type        = string
}


