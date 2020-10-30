output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_ipv6_cidr_block" {
  value = aws_vpc.vpc.ipv6_cidr_block
}

output "vpc_main_route_table_id" {
  value = aws_vpc.vpc.main_route_table_id
}

output "dns_internal_zone_id" {
  value = aws_route53_zone.internal.zone_id
}
