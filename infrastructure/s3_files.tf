resource "aws_s3_object" "delta_insert" {
  bucket = aws_s3_bucket.buckets[0].id
  key    = "emr-code/pyspark/01_delta_spark_insert.py"
  acl    = "private"
  source = "../functions/fn_extract_rais/01_delta_spark_insert.py"
  etag   = filemd5("../functions/fn_extract_rais/01_delta_spark_insert.py")
}