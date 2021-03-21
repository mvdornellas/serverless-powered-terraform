variable "api_gateway_rest_api" {}
variable "function_archive" {}
variable "module_name" {}



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
      "dynamodb:BatchGetItem",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DescribeTable",
      "dynamodb:CreateTable"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "lambda_policy" {
  policy = data.aws_iam_policy_document.lambda_document.json
}

resource "aws_iam_role" "lambda_role" {
  name               = "${var.module_name}-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_document.json
}

resource "aws_iam_policy_attachment" "lambda_attachment" {
  name = "${var.module_name}-attachment"

  roles = [
    aws_iam_role.lambda_role.name,
  ]

  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_api_gateway_resource" "resource_employees" {
   rest_api_id = var.api_gateway_rest_api.id
   parent_id   = var.api_gateway_rest_api.root_resource_id
   path_part   = "employees"
}

output "aws_api_gateway_deployment_employees" {
  value = [
         aws_api_gateway_resource.resource_employees.id,
         aws_api_gateway_method.get_employee.id,
         aws_api_gateway_integration.get_employee.id,
         aws_api_gateway_method.create_employee.id,
         aws_api_gateway_integration.create_employee.id,
  ]
}