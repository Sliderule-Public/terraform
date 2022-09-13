module "infrastructure_bucket" {
  source       = "../src/modules/simple/s3_bucket"
  environment  = var.environment
  region       = var.region
  company_name = var.company_name
  account_id   = local.account_id
  bucket_name  = "infrastructure-eks"
  key_arn      = module.main_key.key_arn
  tags         = var.tags
}

module "server_docs_bucket" {
  source                    = "../src/modules/simple/s3_bucket"
  environment               = var.environment
  region                    = var.region
  company_name              = var.company_name
  account_id                = local.account_id
  bucket_name               = "server-documents"
  key_arn                   = module.main_key.key_arn
  upload_cors_rules_enabled = true
  tags                      = var.tags
}

resource "aws_s3_bucket_object" "object" {
  depends_on = [null_resource.populate_sqs_values[0]]
  bucket = module.infrastructure_bucket.bucket
  key    = "env-files/api/${var.environment}.env"
  source = "${var.environment}.env"
}
