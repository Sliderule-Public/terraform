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
  default = "db.t3.small"
}
variable "availability_zone" {
  type = string
}
variable "skip_final_snapshot" {
  type    = bool
  default = false
}
variable "deploy_read_replica" {
  type    = bool
  default = false
}
