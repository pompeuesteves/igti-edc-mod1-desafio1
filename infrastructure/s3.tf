resource "aws_s3_bucket" "buckets" {
  count  = length(var.bucket_names)
  bucket = "${var.prefix}-${var.bucket_names[count.index]}-${var.account}-tf"

  tags = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  count  = length(var.bucket_names)
  bucket = aws_s3_bucket.buckets[count.index].id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "example" {
  count  = length(var.bucket_names)
  bucket = aws_s3_bucket.buckets[count.index].id
  acl    = "private"
}