output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_az_1.id,
    aws_subnet.public_az_2.id
  ]
}

output "private_web_subnet_ids" {
  value = [
    aws_subnet.private_web_az_1.id,
    aws_subnet.private_web_az_2.id
  ]
}

output "private_db_subnet_ids" {
  value = [
    aws_subnet.private_db_az_1.id,
    aws_subnet.private_db_az_2.id
  ]
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}
