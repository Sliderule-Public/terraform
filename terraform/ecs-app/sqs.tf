module "sqs" {
  source = "git@github.com:Modern-Logic/terraform-modules.git//simple/sqs_queue"
  environment  = var.environment
  company_name = var.company_name
  name         = "sls"
  tags         = var.tags
}
