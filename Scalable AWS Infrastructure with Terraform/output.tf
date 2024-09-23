output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.test.dns_name
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main_vpc.cidr_block
}

output "subnet_public_1_cidr" {
  description = "The CIDR block of public subnet 1"
  value       = aws_subnet.subnet_public_1.cidr_block
}

output "subnet_public_2_cidr" {
  description = "The CIDR block of public subnet 2"
  value       = aws_subnet.subnet_public_2.cidr_block
}

output "subnet_public_3_cidr" {
  description = "The CIDR block of public subnet 3"
  value       = aws_subnet.subnet_public_3.cidr_block
}

output "subnet_public_1_ipv4" {
  description = "The IPv4 addresses of public subnet 1"
  value       = aws_subnet.subnet_public_1.id
}

output "subnet_public_2_ipv4" {
  description = "The IPv4 addresses of public subnet 2"
  value       = aws_subnet.subnet_public_2.id
}

output "subnet_public_3_ipv4" {
  description = "The IPv4 addresses of public subnet 3"
  value       = aws_subnet.subnet_public_3.id
}
