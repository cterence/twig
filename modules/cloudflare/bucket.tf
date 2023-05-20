resource "aws_s3_bucket" "states_bucket" {
  bucket = var.bucket_name
}
