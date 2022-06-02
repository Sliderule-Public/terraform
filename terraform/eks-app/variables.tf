variable "company_name" {
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
  description = "arn of the AWS IAM user who deployed this, used to give access to KMS keys"
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
  description = "ARNs of IAM users to allow decrypt and encrypt access to KMS keys"
}
variable "app_vpc_cidr" {
  type        = string
  description = "desired value for the VPC CIDR if create_vpc is true. If create_vpc is false, then the CIDR of the VPC being used in vpc_id."
}
variable "snapshot_identifier" {
  type    = string
  default = ""
}
variable "initial_database" {
  type = string
  description = "name of initial database in RDS"
}
variable "master_db_username" {
  type = string
  description = "master db username to use for RDS"
}
variable "master_db_password" {
  type = string
  description = "password to user for master user in RDS"
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
variable "create_vpc" {
  type    = bool
  default = true
}
variable "vpc_id" {
  type        = string
  description = "only needed if create_vpc is false"
  default     = ""
}
variable "private_subnet_ids" {
  type        = list(string)
  description = "only needed if create_vpc is false"
  default     = []
}
variable "public_subnet_ids" {
  type        = list(string)
  description = "only needed if create_vpc is false"
  default     = []
}
variable "deploy_eks" {
  type    = bool
  default = true
}
variable "web_eks_port" {
  type    = number
  default = 31255
  description = "used in helm to expose this service"
}
variable "docs_eks_port" {
  type    = number
  default = 31256
  description = "used in helm to expose this service"
}
variable "api_eks_port" {
  type    = number
  default = 31257
  description = "used in helm to expose this service"
}