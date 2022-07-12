variable "company_name" {
  type = string
}
variable "app_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "region" {
  type = string
}
variable "author" {
  type = string
}
variable "tags" {
  type = object({
    Environment       = string
    Company           = string
    Deployment_Method = string
  })
}
variable "kms_grantees" {
  type = list(string)
}
variable "app_vpc_cidr" {
  type = string
}
variable "snapshot_identifier" {
  type    = string
  default = ""
}
variable "initial_database" {
  type = string
}
variable "master_db_username" {
  type = string
}
variable "master_db_password" {
  type = string
}
variable "ecs_domain_names" {
  type        = list(string)
  description = "Domain names, which when combined with var.web_subdomains and var.api_subdomains, create the domains that your ECS services will listen on. If var.deploy_route53_resources is set to true, subdomains will also be created in the Route 53 hosted zones for these domain names."
}
variable "extra_domain_names" {
  type        = list(string)
  default     = []
  description = "If var.deploy_route53_resources is set to true, subdomains will be created in the Route 53 hosted zones for these optional extra domain names. This is only offered to create extra Route 53 entries and can be left empty at any time."
}
variable "grafana_auth" {
  type    = string
  default = ""
}
variable "aws_access_key" {
  type = string
}
variable "aws_secret_key" {
  type = string
}
variable "grafana_email_recipients" {
  type    = string
  default = ""
}
variable "desired_task_count_api" {
  type    = number
  default = 3
}
variable "desired_task_count_web" {
  type    = number
  default = 2
}
variable "minimum_host_count" {
  type    = number
  default = 1
}
variable "maximum_host_count" {
  type    = number
  default = 10
}
variable "deploy_grafana_resources" {
  type    = bool
  default = "false"
}
variable "bastion_ami" {
  type    = string
  default = ""
}
variable "ecs_host_ami" {
  type    = string
  default = ""
}
variable "certificate_arn" {
  type = string
}
variable "ecs_alarms_email_recipients" {
  type    = list(string)
  default = []
}
variable "server_iam_role_policy_statements" {
  type = list(object({
    effect    = string
    actions   = list(string)
    resources = list(string)
  }))
  default = []
  // Alternate default is commented out, it's just here as a reference for how to use this
  //  default = [
  //    {
  //    effect: "Allow",
  //    actions = ["ses:SendRawEmail"]
  //    resources: ["*"]
  //    }
  //  ]
}
variable "skip_final_snapshot" {
  type    = bool
  default = false
}
variable "database_security_group_additional_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
  }))
  default = []
}
variable "services_to_grant_kms_access_to" {
  type    = list(string)
  default = []
}
variable "api_task_memory" {
  type    = number
  default = 31000
}
variable "api_task_vcpu" {
  type    = number
  default = 7800
}
variable "deploy_route53_resources" {
  type    = bool
  default = true
}
variable "elb_idle_timeout" {
  type    = number
  default = 60
}
// Password for the auth0 user in the postgresql database
variable "auth0_password" {
  type = string
}
variable "auth0_domain" {
  type = string
}
variable "auth0_client_id" {
  type = string
}
variable "auth0_secret" {
  type = string
}
variable "host_instance_type" {
  type    = string
  default = "t3.xlarge"
}
variable "bastion_instance_type" {
  type    = string
  default = "t3.small"
}
variable "database_instance_type" {
  type    = string
  default = "db.t2.large"
}
variable "api_subdomains" {
  type = list(string)
}
variable "web_subdomains" {
  type = list(string)
}
variable "redis_node_type" {
  type    = string
  default = "cache.m4.xlarge"
}
variable "use_variable_scripts" {
  type        = bool
  default     = false
  description = "if true, null_resource resources will be used to run scripts that generate var files for kubernetes/aws/shieldrule"
}
variable "api_unhealthy_threshold" {
  type    = number
  default = 2
}
variable "api_health_check_interval" {
  type    = number
  default = 60
}
variable "api_health_check_timeout" {
  type    = number
  default = 10
}
variable "api_healthy_threshold" {
  type    = number
  default = 2
}
variable "domains_to_redirect" {
  type = list(object({
    from = string
    to   = string
  }))
  default = []
}