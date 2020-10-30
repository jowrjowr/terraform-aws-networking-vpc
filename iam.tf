data "aws_iam_policy_document" "vpc_flow" {
  version = "2012-10-17"
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = [
      "*"
    ]
    effect = "Allow"
  }
}

resource "aws_iam_role_policy" "vpc_flow" {
  name   = "vpc_flow_${var.name}_${var.project}_${var.environment}"
  role   = aws_iam_role.vpc_flow.name
  policy = data.aws_iam_policy_document.vpc_flow.json
}


data "aws_iam_policy_document" "cloudwatch_vpc_flow" {
  version = "2012-10-17"
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
    effect = "Allow"
  }
}

resource "aws_iam_role" "vpc_flow" {
  path               = "/${var.project}/${var.environment}/"
  name               = "vpc_flow_${var.name}_${var.project}_${var.environment}"
  description        = "manages vpc flow log writing"
  assume_role_policy = data.aws_iam_policy_document.cloudwatch_vpc_flow.json
  tags = {
    Name        = "${var.name} cloudwatch vpc flow"
    terraform   = "true"
    project     = var.project
    environment = var.environment
  }
}
