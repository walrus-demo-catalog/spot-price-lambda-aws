resource "aws_lambda_function" "spot_price_function" {
  filename      = "get_spot_price.zip"
  function_name = "getSpotPrice"
  role          = aws_iam_role.lambda_execution.arn
  handler       = "get_spot_price.lambda_handler"
  runtime       = "python3.8"

  environment {
    variables = {
      INSTANCE_TYPE = var.instance_type
    }
  }

  depends_on = [null_resource.python_script]
}

resource "null_resource" "python_script" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "curl -o get_spot_price.zip https://seal-demo-1303613262.cos.ap-guangzhou.myqcloud.com/scripts/get_spot_price.zip"
  }
}

resource "aws_iam_policy" "lambda_execution_policy" {
  name = "LambdaExecutionPolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "ec2:DescribeSpotPriceHistory",
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "lambda_execution" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_execution_attachment" {
  name       = "lambda_execution_attachment"
  policy_arn = aws_iam_policy.lambda_execution_policy.arn
  roles      = [aws_iam_role.lambda_execution.name]
}
