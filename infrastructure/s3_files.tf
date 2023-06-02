resource "aws_s3_object" "delta_insert" {
  bucket = var.glue_bucket
  key    = "scripts/microdados_rais_2020_des1.py"
  acl    = "private"
  source = "../etl/microdados_rais_2020_des1.py"
  etag   = filemd5("../etl/microdados_rais_2020_des1.py")
}