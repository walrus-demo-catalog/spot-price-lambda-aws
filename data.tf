data "aws_lambda_invocation" "spot_price" {
  function_name = aws_lambda_function.spot_price_function.function_name
  input = jsonencode({
    "instance_type": var.instance_type
  })
}
