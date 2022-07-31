resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })

}

resource "aws_iam_role_policy" "write_policy" {
  name = "lambda_write_policy"
  role = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [        
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:Get*",
                "dynamodb:Query",
                "dynamodb:Update*",
                "dynamodb:PutItem"
            ],
            "Resource": [
                aws_dynamodb_table.ddbtable.arn
            ]
        }
    ]
}

  )
}