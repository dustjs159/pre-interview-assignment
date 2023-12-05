resource "aws_route53_record" "web_access_domain" {
  zone_id = "${var.hosted_zone_id}"
  name    = "${var.record_value}"
  type    = "A"
  alias {
    name                   = "${var.alb_dns_name}"
    zone_id                = "${var.hosted_zone_id}"
    evaluate_target_health = true
  }
}