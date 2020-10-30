resource "aws_vpc" "vpc" {
  cidr_block                       = var.cidr_block
  assign_generated_ipv6_cidr_block = true
  enable_dns_support               = true
  enable_dns_hostnames             = true
  tags = {
    Name        = "${var.project} ${var.name} ${var.environment}"
    terraform   = "true"
    environment = var.environment
    project     = var.project
  }
}
