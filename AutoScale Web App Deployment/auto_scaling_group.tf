# Create Launch Configuration for ASG
resource "aws_launch_configuration" "app" {
  name                   = "app-launch-configuration"
  image_id               = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.UbuntuKP.key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  security_groups        = [aws_security_group.HTTP-SG.id]
  
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y python3 aws-cli

    INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
    echo "Instance ID: \$INSTANCE_ID" > /var/log/instance_info.log
    echo "Hostname: \$(hostname -f)" >> /var/log/instance_info.log
    echo "Date: \$(date)" >> /var/log/instance_info.log

    # Install Nginx
    yum install -y nginx

    # Create HTML file with your name
    echo "<html><body><h1>Hello, From Mahmoud Sharara Server</h1></body></html>" > /var/www/html/index.html

    # Start Nginx
    systemctl start nginx
    systemctl enable nginx

    # Upload log file to S3 periodically
    while true; do
      aws s3 cp /var/log/instance_info.log s3://cloudkode-project-sharara/instance_logs/\$(hostname)-instance_info.log
      sleep 30 # Upload every 30 seconds
    done
  EOF
}


# Create Auto Scaling Group (ASG)
resource "aws_autoscaling_group" "app" {
  name                  = "ASG"
  launch_configuration  = aws_launch_configuration.app.id
  min_size              = 1
  max_size              = 3
  desired_capacity      = 2
  vpc_zone_identifier   = [aws_subnet.subnet_private_1.id, aws_subnet.subnet_private_2.id]
  target_group_arns     = [aws_lb_target_group.targetgp.arn]

  tag {
    key                 = "Name"
    value               = "ASG_Instance"
    propagate_at_launch = true
  }
}
