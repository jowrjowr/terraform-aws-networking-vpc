resource "aws_flow_log" "vpc" {
  count           = var.flow_logging_enabled ? 1 : 0
  iam_role_arn    = aws_iam_role.vpc_flow.arn
  log_destination = aws_cloudwatch_log_group.vpc_flow.arn
  traffic_type    = var.flow_loging_traffic_type
  vpc_id          = aws_vpc.vpc.id
}

resource "aws_cloudwatch_log_group" "vpc_flow" {
  name              = "/vpc_flow/${var.project}/${var.environment}/${var.name}"
  retention_in_days = var.flow_logging_retention
  tags = {
    Name        = "${var.name} vpc flow"
    terraform   = "true"
    project     = var.project
    environment = var.environment
  }
}
