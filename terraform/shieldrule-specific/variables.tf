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
  type    = list(string)
  default = []
}
