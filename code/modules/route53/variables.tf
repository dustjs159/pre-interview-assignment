variable "alb_arn" {
  type        = string
}

variable "hosted_zone_id" {
  type        = string
  default     = "Z0537273AKMUK1IL6NOL"
}

variable "record_value" {
  type        = string
  default     = "terraform-test.dev-test.gdac.com"
}

variable "alb_dns_name" {
  type        = string
}
