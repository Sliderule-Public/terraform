variable "company_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "security_group_ids" {
  type = list(string)
}
variable "name" {
  type = string
}
variable "node_type" {
  type    = string
  default = "cache.m4.xlarge"
}
variable "subnet_ids" {
  type = list(string)
}
variable "tags" {
  type = object({
    Environment       = string
    Company           = string
    Deployment_Method = string
  })
}