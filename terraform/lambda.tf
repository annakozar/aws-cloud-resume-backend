data "archive_file" "lambda_visitors_counter" {
  type = "zip"

  source_dir  = "${path.module}/../lambda"
  output_path = "${path.module}/../lambda.zip"
}

resource "aws_s3_object" "lambda_visitors_counter" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "lambda.zip"
  source = data.archive_file.lambda_visitors_counter.output_path

  etag = filemd5(data.archive_file.lambda_visitors_counter.output_path)
}

resource "aws_lambda_function" "visitors_counter" {
  function_name = "visitors_Counter"

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.lambda_visitors_counter.key

  runtime = "python3.9"
  handler = "visitors_counter.lambda_handler"

  source_code_hash = data.archive_file.lambda_visitors_counter.output_base64sha256

  role = aws_iam_role.lambda_exec.arn
  
}

resource "aws_lambda_function_url" "test_latest" {
  function_name      = aws_lambda_function.visitors_counter.function_name
  authorization_type = "NONE"
}