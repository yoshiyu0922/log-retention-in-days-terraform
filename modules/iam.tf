resource "aws_iam_role" "log_retention_in_days" {
  name               = "log-retention-in-days-change-lambda"
  assume_role_policy = file("./modules/json/lambda_assume_role_policy.json")
}

resource "aws_iam_policy" "log_retention_in_days" {
  name = "log-retention-in-days-change-lambda-policy"
  policy = file("./modules/json/log_retention_in_days_change_role_policy.json",)
}

resource "aws_iam_role_policy_attachment" "log_retention_in_days" {
  role       = aws_iam_role.log_retention_in_days.name
  policy_arn = aws_iam_policy.log_retention_in_days.arn
}
