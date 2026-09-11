moved {
  from = aws_vpc.main
  to   = module.networking.aws_vpc.main
}

moved {
  from = aws_subnet.public_a
  to   = module.networking.aws_subnet.public_a
}

moved {
  from = aws_subnet.public_b
  to   = module.networking.aws_subnet.public_b
}

moved {
  from = aws_internet_gateway.main
  to   = module.networking.aws_internet_gateway.main
}

moved {
  from = aws_route_table.public
  to   = module.networking.aws_route_table.public
}

moved {
  from = aws_route_table_association.public_a
  to   = module.networking.aws_route_table_association.public_a
}

moved {
  from = aws_route_table_association.public_b
  to   = module.networking.aws_route_table_association.public_b
}

moved {
  from = aws_security_group.ec2
  to   = module.networking.aws_security_group.ec2
}

moved {
  from = aws_instance.web
  to   = module.compute.aws_instance.web
}

moved {
  from = aws_eip.web
  to   = module.compute.aws_eip.web
}

moved {
  from = aws_eip_association.web
  to   = module.compute.aws_eip_association.web
}