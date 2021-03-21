locals {
  update_employee = {
    name              = "update-employee"
    handler           = "handlers.updateEmployee"
    timeout           = "30"
    memory_size       = "128"
    runtime           = "nodejs12.x"
    http_method       = "PUT"
  }
}

resource "aws_lambda_function" "update_employee" {
  filename      = var.function_archive.output_path
  function_name = local.update_employee.name
  role          = aws_iam_role.lambda_role.arn
  handler       = local.update_employee.handler
  runtime     = local.update_employee.runtime
  timeout     = local.update_employee.timeout
  memory_size = local.update_employee.memory_size
}

resource "aws_lambda_permission" "update_employee" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = local.update_employee.name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${var.api_gateway_rest_api.execution_arn}/*/*"
}

resource "aws_api_gateway_method" "update_employee" {
   rest_api_id   = var.api_gateway_rest_api.id
   resource_id   = aws_api_gateway_resource.resource_employees_id.id
   http_method   = local.update_employee.http_method
   authorization = "NONE"
   request_parameters = {
    "method.request.path.employeeId" = true
  }
}

resource "aws_api_gateway_integration" "update_employee" {
   rest_api_id = var.api_gateway_rest_api.id
   resource_id = aws_api_gateway_resource.resource_employees_id.id
   http_method = aws_api_gateway_method.update_employee.http_method
   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.update_employee.invoke_arn
   request_parameters = {
      "integration.request.path.employeeId" = "method.request.path.employeeId"
  }
}