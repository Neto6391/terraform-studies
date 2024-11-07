output "vpc_id" {
  description = "O ID do VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "O CIDR bloco do VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "Lista de IDs publicas subnets"
  value       = aws_subnet.public[*].id
}

output "private_app_subnet_ids" {
  description = "Lista de IDs de aplicações privadas subnets"
  value       = aws_subnet.private_app[*].id
}

output "private_db_subnet_ids" {
  description = "Lista privada de IDs subnet banco de dados"
  value       = aws_subnet.private_db[*].id
}

output "nat_gateway_ids" {
  description = "Lista IDs de NAT Gateway"
  value       = aws_nat_gateway.main[*].id
}

output "bucket" {
  description = "Bucket do S3"
  value       = aws_s3_bucket.my_bucket.bucket
}

output "ec2_ids" {
  description = "Lista de máquinas EC2"
  value       = aws_instance.machine_ec2[*].id
}
