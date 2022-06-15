resource "null_resource" "copy_env_file" {
  count = var.use_variable_scripts == true ? 1 : 0
  depends_on = [module.rds_instance]
  provisioner "local-exec" {
    command = "bash ../bin/copy_env_file.sh ${var.environment}"
  }
}

resource "null_resource" "populate_db_values" {
  count = var.use_variable_scripts == true ? 1 : 0
  depends_on = [module.rds_instance, null_resource.copy_env_file]
  provisioner "local-exec" {
    command = "bash ../bin/populate_db_values.sh ${var.environment} ${module.rds_instance.address} ${var.master_db_username} ${var.master_db_password} ${var.initial_database} ${module.rds_instance.port}"
  }
}

resource "null_resource" "populate_redis_values" {
  count = var.use_variable_scripts == true ? 1 : 0
  depends_on = [module.redis, null_resource.populate_db_values]
  provisioner "local-exec" {
    command = "bash ../bin/populate_redis_values.sh ${var.environment} ${module.redis.endpoint} 6379"
  }
}

resource "null_resource" "populate_sqs_values" {
  count = var.use_variable_scripts == true ? 1 : 0
  depends_on = [module.redis, null_resource.populate_redis_values]
  provisioner "local-exec" {
    command = "bash ../bin/populate_sqs_values.sh ${var.environment} ${module.sqs.name} ${data.aws_caller_identity.current.account_id} ${var.region}"
  }
}

resource "null_resource" "populate_s3_values" {
  count = var.use_variable_scripts == true ? 1 : 0
  depends_on = [null_resource.populate_sqs_values]
  provisioner "local-exec" {
    command = "bash ../bin/populate_s3_values.sh ${var.environment} ${module.server_docs_bucket.bucket}"
  }
}

resource "null_resource" "populate_generic_values" {
  count = var.use_variable_scripts == true ? 1 : 0
  depends_on = [null_resource.populate_s3_values]
  provisioner "local-exec" {
    command = "bash ../bin/populate_generic_values.sh ${var.environment} ${var.company_name}"
  }
}

resource "null_resource" "create_auth0_user" {
  count = var.use_variable_scripts == true ? 1 : 0
  depends_on = [module.rds_instance, module.shared_bastion_auto_scaling_group ]
  provisioner "local-exec" {
    command = "bash ../bin/create_auth0_user.sh ${var.environment} ${module.rds_instance.address} ${var.master_db_username} ${var.master_db_password} ${var.initial_database} ${module.rds_instance.port} ${var.company_name} ${var.auth0_password}"
  }
}