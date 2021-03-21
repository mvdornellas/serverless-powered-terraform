locals {
  get_employee = {
    name              = "get-employee"
    handler           = "handlers.getEmployee"
    timeout           = "30"
    memory_size       = "128"
    runtime           = "nodejs10.x"
    http_method       = "GET"
  }
}

resource "aws_lambda_function" "get_employee" {
  filename      = var.function_archive.output_path
  function_name = local.get_employee.name
  role          = aws_iam_role.lambda_role.arn
  handler       = local.get_employee.handler
  runtime     = local.get_employee.runtime
  timeout     = local.get_employee.timeout
  memory_size = local.get_employee.memory_size
}

resource "aws_lambda_permission" "get_employee" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = local.get_employee.name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${var.api_gateway_rest_api.execution_arn}/*/*"
}

resource "aws_api_gateway_resource" "get_employee" {
  rest_api_id = var.api_gateway_rest_api.id
  parent_id   = aws_api_gateway_resource.resource_employees.id
  path_part   = "{employeeId}"
}

resource "aws_api_gateway_method" "get_employee" {
   rest_api_id   = var.api_gateway_rest_api.id
   resource_id   = aws_api_gateway_resource.get_employee.id
   http_method   = local.get_employee.http_method
   authorization = "NONE"
   request_parameters = {
    "method.request.path.employeeId" = true
  }
}

resource "aws_api_gateway_integration" "get_employee" {
   rest_api_id = var.api_gateway_rest_api.id
   resource_id = aws_api_gateway_resource.get_employee.id
   http_method = aws_api_gateway_method.get_employee.http_method
   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.get_employee.invoke_arn
   request_parameters = {
      "integration.request.path.employeeId" = "method.request.path.employeeId"
  }
}