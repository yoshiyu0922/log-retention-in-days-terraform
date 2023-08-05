data "archive_file" "log_retention_in_days" {
  type        = "zip"
  source_dir  = "./modules/functions/log-retention-in-days"
  output_path = "./modules/functions/dist/log-retention-in-days.zip"
}

resource "aws_lambda_function" "log_retention_in_days" {
  function_name = "log-retention-in-days-changer"
  role          = aws_iam_role.log_retention_in_days.arn
  handler          = "lambda_function.handler"
  runtime          = "python3.9"
  filename         = data.archive_file.log_retention_in_days.output_path
  source_code_hash = data.archive_file.log_retention_in_days.output_base64sha256

  environment {
    variables = {
      RETENTION_IN_DAYS = 731
    }
  }
}