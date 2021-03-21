locals {
  name              = "get-employee"
  handler           = "handlers.getEmployee"
  timeout           = "30"
  memory_size       = "128"
  runtime           = "nodejs10.x"
}

resource "aws_iam_role" "lambda_role" {
  name               = "${local.name}-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_document.json
}

resource "aws_iam_policy_attachment" "lambda_attachment" {
  name = "${local.name}-attachment"

  roles = [
    aws_iam_role.lambda_role.name,
  ]

  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_lambda_function" "get_employee" {
  filename      = var.function_archive.output_path
  function_name = local.name
  role          = aws_iam_role.lambda_role.arn
  handler       = local.handler
  runtime     = local.runtime
  timeout     = local.timeout
  memory_size = local.memory_size
}

resource "aws_lambda_permission" "get_employee" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = local.name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${var.api_gateway_rest_api.execution_arn}/*/*"
}


resource "aws_api_gateway_method" "get_employee" {
   rest_api_id   = var.api_gateway_rest_api.id
   resource_id   = aws_api_gateway_resource.get_employee.id
   http_method   = "GET"
   authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_employee" {
   rest_api_id = var.api_gateway_rest_api.id
   resource_id = aws_api_gateway_resource.get_employee.id
   http_method = aws_api_gateway_method.get_employee.http_method
   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.get_employee.invoke_arn
}


output "aws_api_gateway_deployment_get_employee" {
  value = [
         aws_api_gateway_resource.get_employee.id,
         aws_api_gateway_method.get_employee.id,
         aws_api_gateway_integration.get_employee.id,
  ]
}