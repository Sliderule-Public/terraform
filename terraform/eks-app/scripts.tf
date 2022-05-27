resource "null_resource" "copy_env_file" {
  depends_on = [module.rds_instance]
  provisioner "local-exec" {
    command = "bash ../bin/copy_env_file.sh ${var.environment}"
  }
}

resource "null_resource" "populate_db_values" {
  depends_on = [module.rds_instance, null_resource.copy_env_file]
  provisioner "local-exec" {
    command = "bash ../bin/populate_db_values.sh ${var.environment} ${module.rds_instance.address} ${var.master_db_username} ${var.master_db_password} ${var.initial_database} ${module.rds_instance.port}"
  }
}

resource "null_resource" "populate_redis_values" {
  depends_on = [module.redis, null_resource.populate_db_values]
  provisioner "local-exec" {
    command = "bash ../bin/populate_redis_values.sh ${var.environment} ${module.redis.endpoint} 6379"
  }
}

resource "null_resource" "populate_sqs_values" {
  depends_on = [null_resource.populate_redis_values]
  provisioner "local-exec" {
    command = "bash ../bin/populate_sqs_values.sh ${var.environment} ${module.sqs.name} ${data.aws_caller_identity.current.account_id} ${var.region}"
  }
}

resource "null_resource" "populate_s3_values" {
  depends_on = [null_resource.populate_sqs_values]
  provisioner "local-exec" {
    command = "bash ../bin/populate_s3_values.sh ${var.environment} ${module.server_docs_bucket.bucket}"
  }
}

resource "null_resource" "populate_generic_values" {
  depends_on = [null_resource.populate_s3_values]
  provisioner "local-exec" {
    command = "bash ../bin/populate_generic_values.sh ${var.environment} ${var.company_name}"
  }
}

resource "null_resource" "prepare_kubernetes_yaml_file" {
  depends_on = [aws_eks_cluster.main, null_resource.populate_generic_values]
  provisioner "local-exec" {
    command = "bash ../bin/prepare_kubernetes_yaml_file.sh ${var.environment}"
  }
}

resource "null_resource" "populate_pod_values" {
  depends_on = [aws_eks_cluster.main, null_resource.prepare_kubernetes_yaml_file]
  provisioner "local-exec" {
    command = "bash ../bin/populate_pod_values.sh ${var.environment} ${module.pod_security_group.security_group_id} ${module.ecs_task_role.role_arn}"
  }
}

resource "null_resource" "prepare_eks_oidc_vars" {
  count      = var.deploy_eks == true ? 1 : 0
  depends_on = [aws_eks_cluster.main, null_resource.populate_pod_values]
  provisioner "local-exec" {
    command = "bash ../bin/prepare_eks_oidc_vars.sh ${var.environment} ${var.region} ${module.ecs_task_role.role_arn} ${aws_eks_cluster.main[0].id} ${aws_eks_cluster.main[0].certificate_authority[0].data} ${module.ecs_task_role.role_name} ${aws_eks_cluster.main[0].identity[0].oidc[0].issuer} ${aws_eks_cluster.main[0].endpoint}"
  }
}