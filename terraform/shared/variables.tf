variable "zone_dns_name" {
  type    = string
  default = ""
  description = "Only needed if you plan to deploy Route 53 resources in this stack."
}

variable "region" {
  type = string
  description = "AWS region that ECS resources will be deployed to"
}

variable "service_name" {
  type    = string
  default = "shieldrule"
  description = "Name of the service being deployed"
}

variable "deploy_route53" {
  type    = bool
  default = true
  description = "Option to deploy a Route53 hosted zone. If this is set to true, also set 'zone_dns_name'."
}

variable "deploy_ecr_repositories" {
  type    = bool
  default = true
  description = "Option to deploy ECR repositories through this stack."
}

variable "deploy_ecs_service_linked_role" {
  type    = bool
  default = true
  description = "Boolean, option to deploy a required ECS service-linked role."
}

variable "company_name" {
  type = string
  description = "Name of company"
}

variable "external_aws_account_id" {
  type = string
  description = "AWS account ID for the Sliderule external account"
}

variable "external_id" {
  type = string
  description = "External ID for the external assume role operation"
}

variable "ecs_environments_touchable_by_external_account" {
  type = list(string)
  default = ["dev", "development", "staging", "stage"]
  description = "The environments that are allowed to be interacted with by the external Sliderule support team"
}

variable "allow_external_account_read_metrics" {
  type    = bool
  default = true
  description = "Designates whether the external account can read Cloudwatch metrics"
}