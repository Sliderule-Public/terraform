resource "aws_ssm_parameter" "redis_endpoint" {
  name  = "/${var.company_name}/${var.app_name}/${var.environment}/redis_endpoint"
  type  = "String"
  value = module.redis.endpoint
}

resource "aws_ssm_parameter" "sqs_arn" {
  name  = "/${var.company_name}/${var.app_name}/${var.environment}/sqs_arn"
  type  = "String"
  value = module.sqs.arn
}

resource "aws_ssm_parameter" "private_subnet_1" {
  name  = "/${var.company_name}/${var.app_name}/${var.environment}/private_subnet_1"
  type  = "String"
  value = module.shared_vpc.private_app_subnet_id_0
}

resource "aws_ssm_parameter" "private_subnet_2" {
  name  = "/${var.company_name}/${var.app_name}/${var.environment}/private_subnet_2"
  type  = "String"
  value = module.shared_vpc.private_app_subnet_id_1
}
