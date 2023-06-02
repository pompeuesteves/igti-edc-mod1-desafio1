resource "aws_glue_job" "rais" {
  name              = "microdados_rais_2020_des1"
  tags              = var.tags
  description       = "Glue Job from terraform:  microdados_rais_2020_des1"
  role_arn          = var.iam_role
  glue_version      = "3.0"
  worker_type       = "G.1X"
  number_of_workers = 6
  max_retries       = 0
  timeout           = 30

  command {
    script_location = "s3://aws-glue-igti-${var.account}-${var.aws_region}/scripts/microdados_rais_2020_des1.py"
    python_version  = "3"
  }

  execution_property {
    max_concurrent_runs = 1
  }

  default_arguments = {
    "--job-language"                     = "python"
    "--job-bookmark-option"              = "job-bookmark-enable"
    "--enable-metrics"                   = ""
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-spark-ui"                  = "true"
    "--spark-event-logs-path"            = "s3://aws-glue-igti-${var.account}-${var.aws_region}/sparkHistoryLogs/"
    "--TempDir"                          = "s3://aws-glue-igti-${var.account}-${var.aws_region}/temporary/"
    "--enable-glue-datacatalog"          = ""
    "--class"                            = "GlueApp"
  }
}



resource "aws_glue_crawler" "enem" {
  database_name = var.glue_database_name
  name          = "microdados_rais_2020"
  role          = var.iam_role
  description   = "microdados_rais_2020 (desafio 1 módulo 1)"
  tags          = var.tags
  table_prefix  = "rais2020-"

  s3_target {
    path = "s3://${var.prefix}-${var.bucket_names[1]}-${var.account}-tf/consumer-zone/"
  }
}