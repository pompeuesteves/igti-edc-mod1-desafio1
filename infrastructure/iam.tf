resource "aws_iam_role" "lambda_decompress" {
  name               = "${var.prefix}_Role_Lambda_extract_rais"
  path               = "/"
  description        = "Provides write permissions to CloudWatch Logs and S3 Full Access"
  assume_role_policy = file("./permissions/Role_Lambda_decompress_S3.json")
}

resource "aws_iam_policy" "lambda_decompress" {
  name        = "${var.prefix}_Policy_Lambda_extract_rais"
  path        = "/"
  description = "Provides write permissions to CloudWatch Logs and S3 Full Access"
  policy      = file("./permissions/Policy_Lambda_decompress_S3.json")
}

resource "aws_iam_role_policy_attachment" "lambda_attach" {
  role       = aws_iam_role.lambda_decompress.name
  policy_arn = aws_iam_policy.lambda_decompress.arn
}