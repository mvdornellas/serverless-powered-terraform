resource "aws_api_gateway_rest_api" "employee" {
  name        = "employee"
  description = "Serverless Powered Terraform"
}
resource "aws_api_gateway_deployment" "employee" {
   rest_api_id = aws_api_gateway_rest_api.employee.id
   triggers = {
      redeployment = sha1(jsonencode(module.employees.aws_api_gateway_deployment_employees))
   }

   lifecycle {
    create_before_destroy = true
  }

}

resource "aws_api_gateway_stage" "employee" {
  deployment_id = aws_api_gateway_deployment.employee.id
  rest_api_id   = aws_api_gateway_rest_api.employee.id
  stage_name    = "dev"
}

output "base_url" {
  value = aws_api_gateway_deployment.employee.invoke_url
}