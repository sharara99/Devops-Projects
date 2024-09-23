resource "aws_launch_configuration" "app_new" {
  name                 = "app-launch-configuration-new"
  image_id             = var.ami
  instance_type        = var.instance_type
  key_name             = aws_key_pair.UbuntuKP.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  security_groups      = [aws_security_group.HTTP-SG.id]

  user_data = <<-EOF
    #!/bin/bash
    apt update -y
    apt install -y nginx

    # Create HTML file with your name
    echo "<html><body><h1>Mahmoud Sharara</h1></body></html>" > /var/www/html/index.html

    # Start Nginx
    systemctl start nginx
    systemctl enable nginx
  EOF
}

resource "aws_autoscaling_group" "app" {
  name                 = "ASG"
  launch_configuration = aws_launch_configuration.app_new.id  # Update the ASG to use the new launch configuration
  min_size             = 1
  max_size             = 3
  desired_capacity     = 2
  vpc_zone_identifier  = [
    aws_subnet.subnet_public_1.id,
    aws_subnet.subnet_public_2.id,
    aws_subnet.subnet_public_3.id
  ]
  target_group_arns    = [aws_lb_target_group.targetgp.arn]

  tag {
    key                 = "Name"
    value               = "ASG_Instance"
    propagate_at_launch = true
  }
}
