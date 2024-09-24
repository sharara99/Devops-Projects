output "bastion_instance_id" {
  description = "The ID of the bastion host instance used for secure access to other resources."
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "The public IP address of the bastion host, used for SSH access from external networks."
  value       = aws_instance.bastion.public_ip
}