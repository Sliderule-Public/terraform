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
variable "zone_id" {
  type = string
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
  default = 2
}
variable "desired_task_count_web" {
  type    = number
  default = 2
}
variable "desired_task_count_docs" {
  type    = number
  default = 1
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
variable "domain" {
  type = string
}
variable "api_host_listeners" {
  type    = list(string)
  default = []
}
variable "web_host_listeners" {
  type    = list(string)
  default = []
}
variable "docs_host_listeners" {
  type    = list(string)
  default = []
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
variable "deploy_read_replica" {
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
  default = 15500
}
variable "api_task_vcpu" {
  type    = number
  default = 3900
}
variable "deploy_route53_resources" {
  type    = bool
  default = true
}
variable "elb_idle_timeout" {
  type    = number
  default = 60
}
variable "auth0_password" {
  type = string
}