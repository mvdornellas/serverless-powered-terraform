resource "aws_api_gateway_rest_api" "ton" {
  name        = "ton"
  description = "Serverless Powered Terraform"
}

resource "aws_api_gateway_resource" "proxy" {
   rest_api_id = aws_api_gateway_rest_api.ton.id
   parent_id   = aws_api_gateway_rest_api.ton.root_resource_id
   path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
   rest_api_id   = aws_api_gateway_rest_api.ton.id
   resource_id   = aws_api_gateway_resource.proxy.id
   http_method   = "ANY"
   authorization = "NONE"
}