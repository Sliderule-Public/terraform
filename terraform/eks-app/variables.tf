variable "company_name" {
  type        = string
  description = "used in resource naming"
}
variable "environment" {
  type        = string
  description = "used in resource naming and namespacing"
}
variable "region" {
  type        = string
  description = "aws region to deploy into"
}
variable "app_vpc_cidr" {
  type        = string
  description = "desired value for the VPC CIDR if create_vpc is true. If create_vpc is false, then the CIDR of the VPC being used in vpc_id."
}
variable "initial_database" {
  type        = string
  description = "name of initial database in RDS"
}
variable "master_db_username" {
  type        = string
  description = "master db username to use for RDS"
}
variable "master_db_password" {
  type        = string
  description = "password to user for master user in RDS"
}
variable "tags" {
  type = any
  default     = {}
  description = "optional AWS tags to apply to most resources deployed with this stack"
}
variable "kms_grantees" {
  type        = list(string)
  description = "ARNs of IAM users to allow decrypt and encrypt access to KMS keys"
  default = []
}
variable "snapshot_identifier" {
  type        = string
  default     = ""
  description = "optional snapshot to use to create RDS instance"
}
variable "alarms_email_recipients" {
  type        = list(string)
  default     = []
  description = "list of emails to receive various alarms for this stack"
}
variable "server_iam_role_policy_statements" {
  type = list(object({
    effect    = string
    actions   = list(string)
    resources = list(string)
  }))
  default     = []
  description = "optional additional IAM policies to apply to the IAM role assigned to the EKS tasks"
}
variable "skip_final_snapshot" {
  type        = bool
  default     = false
  description = "if true, will skip the final snapshot if the RDS instance is deleted"
}
variable "deploy_read_replica" {
  type        = bool
  default     = false
  description = "if true, deploys an optional read replica for the RDS instance"
}
variable "database_security_group_additional_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
  }))
  default     = []
  description = "optional additional security group rules for the database security group."
}
variable "services_to_grant_kms_access_to" {
  type        = list(string)
  default     = []
  description = "list of additional AWS services to permit for encrypting / decrypting the KMS keys in this stack"
}
variable "create_vpc" {
  type        = bool
  default     = true
  description = "if true, will create a new VPC to host resources in this stack. If false, vpc_id, private_subnet_ids and public_subnet_ids are required"
}
variable "vpc_id" {
  type        = string
  description = "only needed if create_vpc is false. VPC to use to host resources in this stack"
  default     = ""
}
variable "private_subnet_ids" {
  type        = list(string)
  description = "only needed if create_vpc is false. Private subnets to use to host some private resources in this stack"
  default     = []
}
variable "public_subnet_ids" {
  type        = list(string)
  description = "only needed if create_vpc is false. Public subnets to use to host some public resources in this stack"
  default     = []
}
variable "deploy_eks" {
  type        = bool
  default     = true
  description = "if true, a new EKS cluster is created"
}
variable "web_eks_port" {
  type        = number
  default     = 31255
  description = "used in helm to expose the web service through security group rules"
}
variable "docs_eks_port" {
  type        = number
  default     = 31256
  description = "used in helm to expose the docs service through security group rules"
}
variable "api_eks_port" {
  type        = number
  default     = 31257
  description = "used in helm to expose the API service through security group rules"
}
variable "use_variable_scripts" {
  type = bool
  default = false
  description = "if true, null_resource resources will be used to run scripts that generate var files for kubernetes/aws/shieldrule"
}
variable "certificate_arn" {
  default = ""
  description = "ARN of the AWS ACM certificate to use with optional EKS-made application load balancers. Only required if var.use_scripts is true and you're using Sliderule-provided AWS EKS ALB functionality."
  type = string
}
variable "database_instance_type" {
  type    = string
  default = "db.t3.xlarge"
}
variable "eks_cluster_name" {
  type    = string
  default = ""
  description = "Name of EKS cluster to be used to create OIDC providers for IAM roles. Only required if deploy_eks is false"
}
variable "app_name" {
  type = string
  default = "shieldrule"
  description = "used to build an SSH key name for the optional EKS node group."
}
variable "iam_arns_to_grant_sns_kms_access_to" {
  type    = list(string)
  default = []
}
