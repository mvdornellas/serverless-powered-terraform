locals {
  delete_employee = {
    name              = "delete-employee"
    handler           = "handlers.deleteEmployee"
    timeout           = "30"
    memory_size       = "128"
    runtime           = "nodejs12.x"
    http_method       = "DELETE"
  }
}

resource "aws_lambda_function" "delete_employee" {
  filename      = var.function_archive.output_path
  function_name = local.delete_employee.name
  role          = aws_iam_role.lambda_role.arn
  handler       = local.delete_employee.handler
  runtime     = local.delete_employee.runtime
  timeout     = local.delete_employee.timeout
  memory_size = local.delete_employee.memory_size
}

resource "aws_lambda_permission" "delete_employee" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = local.delete_employee.name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${var.api_gateway_rest_api.execution_arn}/*/*"
}

resource "aws_api_gateway_method" "delete_employee" {
   rest_api_id   = var.api_gateway_rest_api.id
   resource_id   = aws_api_gateway_resource.resource_employees_id.id
   http_method   = local.delete_employee.http_method
   authorization = "NONE"
   request_parameters = {
    "method.request.path.employeeId" = true
  }
}

resource "aws_api_gateway_integration" "delete_employee" {
   rest_api_id = var.api_gateway_rest_api.id
   resource_id = aws_api_gateway_resource.resource_employees_id.id
   http_method = aws_api_gateway_method.delete_employee.http_method
   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.delete_employee.invoke_arn
   request_parameters = {
      "integration.request.path.employeeId" = "method.request.path.employeeId"
  }
}