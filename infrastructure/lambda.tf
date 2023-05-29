resource "aws_lambda_function" "lambda_decompress" {
  filename      = "lambda_function_payload.zip"
  function_name = "${var.prefix}_extract_rais"
  role          = aws_iam_role.lambda_decompress.arn
  handler       = "lambda_function.handler"
  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  source_code_hash = filebase64sha256("lambda_function_payload.zip")
  runtime          = "python3.8"
  timeout          = 900
  memory_size      = 1024

  tags = var.tags
}