# Create IAM Role for EC2
resource "aws_iam_role" "ec2_role" {
  name = "ec2_log_upload_role" # Updated role name for clarity
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "ec2_log_upload_role"
    Environment = var.Environment
    Owner       = var.Owner
  }
}

# Create IAM Policy for S3 Access
resource "aws_iam_policy" "s3_policy" {
  name = "s3_log_upload_policy" # Updated policy name for clarity
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ],
        Effect = "Allow",
        Resource = [
          "arn:aws:s3:::cloudkode-project-sharara",
          "arn:aws:s3:::cloudkode-project-sharara/*"
        ]
      }
    ]
  })

  tags = {
    Name        = "s3_log_upload_policy"
    Environment = var.Environment
    Owner       = var.Owner
  }
}

# Attach the IAM Policy to the EC2 Role
resource "aws_iam_role_policy_attachment" "ec2_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

# Create an IAM Instance Profile and Attach the IAM Role to EC2
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name

  tags = {
    Name        = "ec2_instance_profile"
    Environment = var.Environment
    Owner       = var.Owner
  }
}
