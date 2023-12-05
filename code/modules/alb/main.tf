resource "aws_alb" "demo_alb" {
    name = "demo-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [
        "${var.alb_security_group}"
        ]
    subnets = [
        "${var.public_subnet_2a}", 
        "${var.public_subnet_2c}"
        ]
}

resource "aws_alb_listener" "demo_alb_https_listener" {
    load_balancer_arn = aws_alb.demo_alb.arn
    port = 443
    ssl_policy = "${var.alb_ssl_policy}"
    certificate_arn = "${var.acm_arm}"
    default_action {
        type = "fixed-response"
        fixed_response {
            content_type = "text/plain"
            message_body = "Service undefined"
            status_code  = "503"
        }
    }
}

resource "aws_alb_listener" "demo_http_listener" {
    load_balancer_arn = aws_alb.demo_alb.arn
    port = 80
    default_action {
        type = "redirect"
        redirect {
            port        = "443"
            protocol    = "HTTPS"
            status_code = "HTTP_301"
        }
    }
}

resource "aws_alb_target_group" "demo_target_group" {
    name = "alb-target-group"
    target_type = "instance"
    port = 80
    protocol = "HTTP"
    vpc_id = "${var.vpc_id}"
    health_check {
        interval = 5
        path = "/"
        port = 80
        healthy_threshold = 3
        unhealthy_threshold = 3
    }
}

resource "aws_alb_listener_rule" "alb_rule_web" {
    listener_arn = aws_alb_listener.demo_alb_https_listener.arn
    priority     = 100
    action {
        type = "forward"
        target_group_arn = aws_alb_target_group.demo_target_group.arn
    }
    condition {
        host_header {
        values = ["${var.alb_listener_host_header}"]
        }
    }
}

resource "aws_lb_target_group_attachment" "demo_target_group_attachment" {
  target_group_arn = aws_alb_target_group.demo_target_group.arn
  target_id        = "${var.target_instance_id}"
  port             = 80
}