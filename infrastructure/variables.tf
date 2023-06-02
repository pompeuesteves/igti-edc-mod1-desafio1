variable "aws_region" {
  default = "us-east-2"
}

variable "account" {
  default = "713051429766"
}

variable "tags" {
  type = map(any)
  default = {
    IES       = "IGTI"
    CURSO     = "EDC"
    Project   = "RAIS"
    ManagedBy = "Terraform"
  }
}

variable "prefix" {
  default = "datalake-igti-edc"
}

variable "bucket_names" {
  description = "Create S3 buckets with these names"
  type        = list(string)
  default = [
    "raw-zone",
    "staging-zone"
  ]
}

#iam_role criado no repositório igti-edc-mod1-exercise1
variable "iam_role" {
  default = "arn:aws:iam::713051429766:role/AWSGlueServiceRole-IGTI-tf"
}

# glue database criado no repositório igti-edc-mod1-exercise1
variable "glue_database_name" {
  default = "datalake-igti"
}

# glue database criado no repositório igti-edc-mod1-exercise1
variable "glue_bucket" {
  default = "aws-glue-igti-713051429766-us-east-2"
}