output "vpc_id" {
  value       = aws_vpc.demo_vpc.id
}

output "public_subnet_2a_id" {
  value       = aws_subnet.public_subnet_2a.id
}

output "public_subnet_2c_id" {
  value       = aws_subnet.public_subnet_2c.id
}

output "private_subnet_2a_id" {
  value       = aws_subnet.private_subnet_2a.id
}

output "private_subnet_2c_id" {
  value       = aws_subnet.private_subnet_2c.id
}


