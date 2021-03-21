resource "aws_api_gateway_rest_api" "ton" {
  name        = "ton"
  description = "Serverless Powered Terraform"
}

resource "aws_api_gateway_resource" "aws_api_gateway_resource_employees" {
   rest_api_id = aws_api_gateway_rest_api.ton.id
   parent_id   = aws_api_gateway_rest_api.ton.root_resource_id
   path_part   = "employees"
}
resource "aws_api_gateway_method" "get_employee" {
   rest_api_id   = aws_api_gateway_rest_api.ton.id
   resource_id   = aws_api_gateway_resource.aws_api_gateway_resource_employees.id
   http_method   = "GET"
   authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_employee_integration" {
   rest_api_id = aws_api_gateway_rest_api.ton.id
   resource_id = aws_api_gateway_resource.aws_api_gateway_resource_employees.id
   http_method = aws_api_gateway_method.get_employee.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = module.employees.get_employee_invoke_arn
}

resource "aws_api_gateway_deployment" "apideploy" {
   rest_api_id = aws_api_gateway_rest_api.ton.id
   triggers = {
      redeployment = sha1(jsonencode([
         aws_api_gateway_resource.aws_api_gateway_resource_employees.id,
         aws_api_gateway_method.get_employee.id,
         aws_api_gateway_integration.get_employee_integration.id,
      ]))
   }
}

resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.apideploy.id
  rest_api_id   = aws_api_gateway_rest_api.ton.id
  stage_name    = "dev"
}

output "base_url" {
  value = aws_api_gateway_deployment.apideploy.invoke_url
}