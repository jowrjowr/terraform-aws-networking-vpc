# EC2 instances will likely need access to teleport
# easier to just put this everywhere

resource "aws_route53_zone" "internal" {
  name    = "domain.tld"
  comment = "${var.project} ${var.name} ${var.environment} internal zone"

  vpc {
    vpc_id = aws_vpc.vpc.id
  }
}

resource "aws_route53_record" "internal_teleport-v4" {
  zone_id = aws_route53_zone.internal.zone_id
  name    = data.terraform_remote_state.master_terraform.outputs.teleport_hostname
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.master_terraform.outputs.teleport_dns_name
    zone_id                = data.terraform_remote_state.master_terraform.outputs.teleport_zone_id
    evaluate_target_health = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

#

data "aws_db_instance" "database" {
  db_instance_identifier = "primary-${var.environment}"
  tags = {
    Name        = "${var.name} ${var.project} database"
    environment = var.environment
    project     = var.project
  }
}


resource "aws_route53_record" "database_cname" {
  zone_id = aws_route53_zone.internal.zone_id
  name    = "db.${var.environment}.domain.tld"
  type    = "CNAME"
  ttl     = "300"

  records = [
    data.aws_db_instance.database.address
  ]

  lifecycle {
    create_before_destroy = true
  }
}
