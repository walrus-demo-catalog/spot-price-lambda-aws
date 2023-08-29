output "spot_instance_price" {
  value = jsondecode(data.aws_lambda_invocation.spot_price.result)["spot_price"]
}
