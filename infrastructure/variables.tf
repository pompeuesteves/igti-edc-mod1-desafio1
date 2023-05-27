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
