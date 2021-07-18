################################
# Network
################################
output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_id_0" {
  value = aws_subnet.public[0].id
}

output "public_subnet_id_1" {
  value = aws_subnet.public[1].id
}

output "private_subnet_id_0" {
  value = aws_subnet.private[0].id
}

output "private_subnet_id_1" {
  value = aws_subnet.private[1].id
}
