resource "aws_api_gateway_rest_api" "ton" {
  name        = "ton"
  description = "Serverless Powered Terraform"
}
resource "aws_api_gateway_deployment" "ton" {
   rest_api_id = aws_api_gateway_rest_api.ton.id
   triggers = {
      redeployment = sha1(jsonencode(module.employees.aws_api_gateway_deployment_employees))
   }
}

resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.ton.id
  rest_api_id   = aws_api_gateway_rest_api.ton.id
  stage_name    = "dev"
}

output "base_url" {
  value = aws_api_gateway_deployment.ton.invoke_url
}