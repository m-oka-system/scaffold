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

output "elb_sg_id" {
  value = aws_security_group.elb.id
}

output "web_sg_id" {
  value = aws_security_group.web.id
}

output "app_sg_id" {
  value = aws_security_group.app.id
}

output "rds_sg_id" {
  value = aws_security_group.rds.id
}

################################
# Key pair
################################
output "key_name" {
  value = aws_key_pair.this.key_name
}

################################
# RDS
################################
output "rds_endpoint" {
  value = aws_db_instance.this.endpoint
}
