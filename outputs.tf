output "vpc_id" {
  value = aws_vpc.default.id
}

output "vpc_cidr" {
  value = aws_vpc.default.cidr_block
}

output "vpc_public_subnets" {
  value = {
    for subnet in aws_subnet.public-default :
    subnet.id => subnet.cidr_block
  }
}

output "vpc_private_subnets" {
  value = {
    for subnet in aws_subnet.public-default :
    subnet.id => subnet.cidr_block
  }
}