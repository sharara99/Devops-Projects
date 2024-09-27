resource "aws_launch_configuration" "app" {
  name                 = "app-launch-configuration"
  image_id             = var.ami
  instance_type        = var.instance_type
  key_name             = aws_key_pair.UbuntuKP.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  security_groups      = [aws_security_group.HTTP-SG.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y nginx

    # Install AWS CLI
    sudo apt install -y awscli

    # Start and enable Nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx

    # Create HTML file with your name
    echo "<html><body><h1>Welcome to Mahmoud Sharara, Web Server</h1>Hostname: $(hostname -f)</body></html>" > /var/www/html/index.html

    # Restart Nginx to apply the changes
    sudo systemctl restart nginx
    sudo systemctl enable nginx

    
  EOF
}


# Create Auto Scaling Group (ASG)
resource "aws_autoscaling_group" "app" {
  name                 = "ASG"
  launch_configuration = aws_launch_configuration.app.id
  min_size             = 1
  max_size             = 3
  desired_capacity     = 2
  vpc_zone_identifier  = [aws_subnet.subnet_private_1.id, aws_subnet.subnet_private_2.id]
  target_group_arns    = [aws_lb_target_group.targetgp.arn]

  tag {
    key                 = "Name"
    value               = "ASG_Instance"
    propagate_at_launch = true
  }
}

# Fetch the instance details based on Auto Scaling Group instances
data "aws_instances" "asg_instances" {
  depends_on = [aws_autoscaling_group.app]  # Ensures instances are launched before fetching

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }

  filter {
    name   = "tag:Name"
    values = ["ASG_Instance"]
  }
}
