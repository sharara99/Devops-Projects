resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet_public_1.id
  key_name               = aws_key_pair.UbuntuKP.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  # Enable public IP assignment
  associate_public_ip_address = true

  # Attach IAM instance profile
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name        = "bastion-host"
    Environment = var.Environment
    Owner       = var.Owner
  }
}
