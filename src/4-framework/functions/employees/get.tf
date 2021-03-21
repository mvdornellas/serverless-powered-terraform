variable "api_gateway_rest_api" {}
variable "function_archive" {}
# variable "aws_api_gateway_method" {}

locals {
  name              = "get-employee"
  handler           = "handlers.getEmployee"
  timeout           = "30"
  memory_size       = "128"
  runtime           = "nodejs10.x"
}

data "aws_iam_policy_document" "lambda_assume_role_document" {
  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "lambda_document" {
  version = "2012-10-17"

  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "cloudwatch:PutMetricData",
      "kms:*",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "lambda_policy" {
  policy = data.aws_iam_policy_document.lambda_document.json
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

resource "aws_lambda_function" "lambda" {
  filename      = var.function_archive.output_path
  function_name = local.name
  role          = aws_iam_role.lambda_role.arn
  handler       = local.handler
  runtime     = local.runtime
  timeout     = local.timeout
  memory_size = local.memory_size
}

resource "aws_lambda_permission" "lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = local.name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${var.api_gateway_rest_api.execution_arn}/*/*"
}

output "get_employee_invoke_arn" {
  value = aws_lambda_function.lambda.invoke_arn
}