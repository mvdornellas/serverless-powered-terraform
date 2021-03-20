
data "archive_file" "function_archive" {
  type        = "zip"
  source_dir  = "${path.module}/../dist"
  output_path = "${path.module}/../dist/function.zip"
}

module "employees" {
    function_archive = data.archive_file.function_archive
    api_gateway_rest_api = aws_api_gateway_rest_api.ton
    source = "./../src/4-framework/functions/employees"
}