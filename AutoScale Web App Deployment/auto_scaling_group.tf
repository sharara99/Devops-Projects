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
    # Update and install necessary packages
    sudo apt update -y
    sudo apt install -y python3 awscli

    # Get the instance ID and hostname
    INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
    HOSTNAME=$(hostname -f)

    # Log instance details
    echo "Instance ID: \$INSTANCE_ID" | sudo tee /var/log/instance_info.log
    echo "Hostname: \$HOSTNAME" | sudo tee -a /var/log/instance_info.log
    echo "Date: \$(date)" | sudo tee -a /var/log/instance_info.log

    # Install Nginx
    sudo apt install -y nginx

    # Create an HTML file with your name and instance information
    echo "<html><body><h1>Hello, From Mahmoud Sharara Server</h1><p>Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p><p>Hostname: $(hostname -f)</p></body></html>" | sudo tee /var/www/html/index.html

    # Start and enable Nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx

    # Upload the log file to S3 periodically
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
