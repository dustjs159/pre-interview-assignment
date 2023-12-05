resource "aws_instance" "demo_instance" {
    ami = "${var.ami}"
    instance_type = "t3.micro"
    key_name = "${var.key_pair}"
    subnet_id = "${var.private_subnet_2a}"
    vpc_security_group_ids = [
        "${var.ec2_security_group}"
    ]
    associate_public_ip_address = true
    user_data = <<EOF
    #!/bin/bash
    apt update && apt upgrade -y
    apt install nginx -y
    echo "<h1> Hello Nginx Web Server! Host : $(hostname)" > /var/www/html/index.nginx-debian.html
    nginx_conf="/etc/nginx/nginx.conf"
    uncommented_line="server_tokens off"
    sed -i "s/# $uncommented_line/$uncommented_line/" $nginx_conf
    systemctl restart nginx && systemctl enable nginx
    EOF   
}