module "sqs" {
  source       = "../src/modules/simple/sqs_queue"
  environment  = var.environment
  company_name = var.company_name
  name         = "sls"
  tags         = var.tags
}
