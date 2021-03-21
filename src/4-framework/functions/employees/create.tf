locals {
    create_employee = {
        name              = "create-employee"
        handler           = "handlers.createEmployee"
        timeout           = "30"
        memory_size       = "128"
        runtime           = "nodejs12.x"
        http_method       = "POST"
    }

}

resource "aws_lambda_function" "create_employee" {
  filename      = var.function_archive.output_path
  function_name = local.create_employee.name
  role          = aws_iam_role.lambda_role.arn
  handler       = local.create_employee.handler
  runtime     = local.create_employee.runtime
  timeout     = local.create_employee.timeout
  memory_size = local.create_employee.memory_size
}

resource "aws_lambda_permission" "create_employee" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = local.create_employee.name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${var.api_gateway_rest_api.execution_arn}/*/*"
}


resource "aws_api_gateway_method" "create_employee" {
   rest_api_id   = var.api_gateway_rest_api.id
   resource_id   = aws_api_gateway_resource.resource_employees.id
   http_method   = local.create_employee.http_method
   authorization = "NONE"
}

resource "aws_api_gateway_integration" "create_employee" {
   rest_api_id = var.api_gateway_rest_api.id
   resource_id = aws_api_gateway_resource.resource_employees.id
   http_method = aws_api_gateway_method.create_employee.http_method
   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.create_employee.invoke_arn
}
