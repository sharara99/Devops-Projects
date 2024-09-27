output "vpc_id" {
  description = "The ID of the created VPC"
  value       = [aws_vpc.main_vpc.id, aws_vpc.main_vpc.cidr_block]
}

output "public_subnet_cidrs" {
  description = "The IDs of the public subnets"
  value       = [aws_subnet.subnet_public_1.cidr_block, aws_subnet.subnet_public_2.cidr_block]
}

output "private_subnet_cidrs" {
  description = "The IDs of the public subnets"
  value       = [aws_subnet.subnet_private_1.cidr_block, aws_subnet.subnet_private_2.cidr_block]
}

output "bastion_public_ip" {
  description = "The public IP of the bastion host"
  value       = aws_instance.bastion.public_ip
}

output "load_balancer_dns" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.test.dns_name
}

# Output the private IPs of the instances in the Auto Scaling Group
output "private_instance_ips" {
  description = "Private IP addresses of instances in the Auto Scaling Group"
  value       = data.aws_instances.asg_instances.private_ips
}
