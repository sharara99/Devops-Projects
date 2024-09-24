# Create an S3 bucket resource
resource "aws_s3_bucket" "bucket1" {
  bucket = "cloudkode-project-sharara"

  force_destroy       = true
  object_lock_enabled = false

  tags = {
    Name        = "CloudKode-Project"
    Environment = var.Environment
    Owner       = var.Owner
  }
}