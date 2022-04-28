output "private_subnet_ids" {
  value = [aws_subnet.private0.id, aws_subnet.private1.id]
}

output "public_subnet_ids" {
  value = [aws_subnet.public0.id, aws_subnet.public1.id]
}

output "public_subnet_ids_for_load_balancers" {
  value = [aws_subnet.public0.id, aws_subnet.public1.id]
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet_id_0" {
  value = aws_subnet.private0.id
}

output "private_subnet_id_1" {
  value = aws_subnet.private1.id
}

output "private_app_subnet_id_0" {
  value = aws_subnet.private_app_0.id
}

output "private_app_subnet_id_1" {
  value = aws_subnet.private_app_1.id
}

output "az_1" {
  value = data.aws_availability_zones.available.names[0]
}
