// Only needed if you plan to deploy Route 53 resources in this stack. Otherwise, leave blank.
variable "zone_dns_name" {
  type    = string
  default = ""
}

// AWS region that ECS resources will be deployed to
variable "region" {
  type = string
}

// Name of the service being deployed, most likely 'shieldrule'
variable "service_name" {
  type    = string
  default = "shieldrule"
}

// Boolean, option to deploy a Route53 hosted zone. If this is set to true, also set 'zone_dns_name'.
variable "deploy_route53" {
  type    = bool
  default = true
}

// Boolean, option to deploy ECR repositories through this stack.
variable "deploy_ecr_repositories" {
  type    = bool
  default = true
}

// Boolean, option to deploy a required ECS service-linked role. In a new AWS account this is probably necessary.
// In an older account that is already using ECS, this may not be necessary.
variable "deploy_ecs_service_linked_role" {
  type    = bool
  default = true
}

// Company name
variable "company_name" {
  type = string
}

// AWS account ID for the external account. Provided by us
variable "external_aws_account_id" {
  type = string
}

// External ID for the external assume role operation. Provided by us
variable "external_id" {
  type = string
}

// The environments that are allowed to be interacted with by the external shieldrule support team
variable "ecs_environments_touchable_by_external_account" {
  type = list(string)
  default = ["dev", "development", "staging", "stage"]
}
