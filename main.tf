resource "aws_vpc" "default" {
  cidr_block                       = "10.${var.main_octet}.0.0/16"
  enable_dns_hostnames             = true
  enable_dns_support               = true
  instance_tenancy                 = "default"
  assign_generated_ipv6_cidr_block = true

  tags = {
    "Name" = "${var.vpc-name}"
  }
}

resource "aws_vpc_dhcp_options" "domain_settings_local" {
  domain_name         = "ec2.internal ${var.domain_settings_local}"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    Name = "domain_settings_local"
  }
}

resource "aws_vpc_dhcp_options_association" "domain_settings_local" {
  vpc_id          = aws_vpc.default.id
  dhcp_options_id = aws_vpc_dhcp_options.domain_settings_local.id
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "${var.vpc-name}-Gateway"
  }
}

#Private (Green Zone)

resource "aws_subnet" "private-default" {
  for_each = var.private_subnet

  vpc_id                  = aws_vpc.default.id
  cidr_block              = cidrsubnet(aws_vpc.default.cidr_block, 8, each.value)
  availability_zone       = each.key
  map_public_ip_on_launch = false

  tags = {
    "Name" = "${each.key}-${each.value}"
  }
}

#Public (Red Zone)

resource "aws_subnet" "public-default" {
  for_each = var.public_subnet

  vpc_id                  = aws_vpc.default.id
  cidr_block              = cidrsubnet(aws_vpc.default.cidr_block, 8, each.value)
  availability_zone       =  each.key
  map_public_ip_on_launch = false

  tags = {
    "Name" = "${each.key}-${each.value}"
  }
}

#Route Tabel

resource "aws_route_table" "default-public-route" {
  vpc_id = aws_vpc.default.id

  tags = {
    "Name" = "${var.vpc-name} Public Route"
  }
}

resource "aws_route_table" "main-default-route-table" {
  vpc_id = aws_vpc.default.id

  tags = {
    "Name" = "Main ${var.vpc-name} Route Table"
  }
}

resource "aws_route" "public-to-internet" {
  route_table_id         = aws_route_table.default-public-route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
  depends_on             = [aws_route_table.default-public-route]
}


#Route Table Associations
resource "aws_main_route_table_association" "main" {
  vpc_id         = aws_vpc.default.id
  route_table_id = aws_route_table.main-default-route-table.id
}

resource "aws_route_table_association" "public-default" {
  for_each = var.public_subnet

  subnet_id      = aws_subnet.public-default[each.key].id
  route_table_id = aws_route_table.default-public-route.id
}

#Network ACL
resource "aws_network_acl" "aws_network_acl" {
  vpc_id = aws_vpc.default.id

  ingress {
    from_port  = 0
    to_port    = 0
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
  }

  egress {
    from_port  = 0
    to_port    = 0
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
  }

  tags = {}
}


