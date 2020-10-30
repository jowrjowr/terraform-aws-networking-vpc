resource "aws_kms_key" "cloudwatch" {
  description             = "${var.name} ${var.project} cloudwatch vpc flow log"
  deletion_window_in_days = 30
  tags = {
    Name        = "${var.name} cloudwatch vpc flow"
    terraform   = "true"
    project     = var.project
    environment = var.environment
  }
}
