# Create an S3 bucket resource
resource "aws_s3_bucket" "bucket1" {
  bucket = "sharara-depi-project"

  force_destroy       = true
  object_lock_enabled = false

  tags = {
    Name        = "sharara-depi-project"
    Environment = var.Environment
    Owner       = var.Owner
  }
}