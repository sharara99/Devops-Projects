output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.test.dns_name
}

output "subnet_public_1_id" {
  value       = aws_subnet.subnet_public_1.id
  description = "ID of the first public subnet"
}

output "subnet_public_1_cidr" {
  value       = aws_subnet.subnet_public_1.cidr_block
  description = "CIDR block of the first public subnet"
}

output "subnet_public_2_id" {
  value       = aws_subnet.subnet_public_2.id
  description = "ID of the second public subnet"
}

output "subnet_public_2_cidr" {
  value       = aws_subnet.subnet_public_2.cidr_block
  description = "CIDR block of the second public subnet"
}

output "subnet_private_1_id" {
  value       = aws_subnet.subnet_private_1.id
  description = "ID of the first private subnet"
}

output "subnet_private_1_cidr" {
  value       = aws_subnet.subnet_private_1.cidr_block
  description = "CIDR block of the first private subnet"
}

output "subnet_private_2_id" {
  value       = aws_subnet.subnet_private_2.id
  description = "ID of the second private subnet"
}

output "subnet_private_2_cidr" {
  value       = aws_subnet.subnet_private_2.cidr_block
  description = "CIDR block of the second private subnet"
}

output "bastion_instance_id" {
  description = "The ID of the bastion host instance used for secure access to other resources."
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "The public IP address of the bastion host, used for SSH access from external networks."
  value       = aws_instance.bastion.public_ip
}