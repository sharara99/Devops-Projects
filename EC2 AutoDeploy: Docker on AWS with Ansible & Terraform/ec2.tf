resource "aws_instance" "bastion" {
  ami                        = var.ami
  instance_type             = var.instance_type
  subnet_id                 = aws_subnet.subnet_public_1.id
  key_name                  = aws_key_pair.UbuntuKP.key_name
  vpc_security_group_ids    = [aws_security_group.bastion_sg.id]

  # Enable public IP assignment
  associate_public_ip_address = true

  tags = {
    Name        = "Python-App-Server"
    Environment = var.Environment
    Owner       = var.Owner
  }

  # Copy the Dockerfile
  provisioner "file" {
    source      = "Dockerfile"                # Local path to your Dockerfile
    destination = "/home/ubuntu/Dockerfile"   # Remote destination on the EC2 instance

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.pk.private_key_pem
      host        = self.public_ip
    }
  }

  # Copy the app.py
  provisioner "file" {
    source      = "app.py"                    # Local path to your app.py file
    destination = "/home/ubuntu/app.py"       # Remote destination on the EC2 instance

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.pk.private_key_pem
      host        = self.public_ip
    }
  }

  # Copy the requirements.txt
  provisioner "file" {
    source      = "requirements.txt"          # Local path to your requirements.txt file
    destination = "/home/ubuntu/requirements.txt" # Remote destination on the EC2 instance

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.pk.private_key_pem
      host        = self.public_ip
    }
  }

  # Ensure the instance is created after the key pair
  depends_on = [aws_key_pair.UbuntuKP]
}
