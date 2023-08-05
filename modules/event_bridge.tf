resource "aws_cloudwatch_event_rule" "every_month" {
  name                = "log-retention-in-date-update-every-month"
  description         = "Fires every month"
  schedule_expression = "cron(0 0 1 * ? *)"
}

resource "aws_cloudwatch_event_target" "output_report_every_month" {
  rule      = aws_cloudwatch_event_rule.every_month.name
  arn       = aws_lambda_function.log_retention_in_days.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_output_report" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.log_retention_in_days.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_month.arn
}