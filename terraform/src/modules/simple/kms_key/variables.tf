variable "company_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "region" {
  type = string
}
variable "usage_grantee_arns" {
  type    = list(string)
  default = []
}
variable "key_name" {
  type = string
}
variable "policy" {
  type = string
  default = ""
}
variable "account_id" {
  type = string
}
variable "tags" {
  type = object({
    Environment       = string
    Company           = string
    Deployment_Method = string
  })
}
