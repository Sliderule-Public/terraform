variable "environment" {
  type = string
}
variable "company_name" {
  type = string
}
variable "region" {
  type = string
}
variable "cluster_name" {
  type = string
}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "role_arn" {
  type = string
}
variable "snapshot_identifier" {
  type    = string
  default = ""
}
variable "security_group" {
  type = string
}
variable "kms_key_arn" {
  type = string
}
variable "initial_database" {
  type = string
}
variable "master_username" {
  type = string
}
variable "master_password" {
  type = string
}
variable "tags" {
  type = object({
    Environment       = string
    Company           = string
    Deployment_Method = string
  })
}
variable "instance_type" {
  type    = string
  default = "db.t3.xlarge"
}
variable "reader_instance_type" {
  type    = string
  default = "db.t3.xlarge"
}
variable "availability_zone" {
  type = string
}
variable "skip_final_snapshot" {
  type    = bool
  default = false
}
variable "name_override" {
  type        = string
  default     = "new-public"
  description = "This is a workaround for incompatibility for two stacks that use this module, ecs-app and eks-app"
}
variable "sns_arn" {
  type = string
}

variable "deploy_read_replica" {
  type        = bool
  default     = false
  description = "Whether to add a read replica"
}
variable "use_only_private_subnets" {
  type    = bool
  default = false
  description = "If true, will use only private subnets"
}