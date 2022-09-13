variable "environment" {
  type = string
}
variable "company_name" {
  type = string
}
variable "template_name" {
  type = string
}
variable "region" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "key_name" {
  type = string
}
variable "ami" {
  type = string
}
variable "instance_profile_name" {
  type    = string
  default = ""
}
variable "vpc_security_group_ids" {
  type    = list(string)
  default = []
}
variable "user_data" {
  type    = string
  default = ""
}
variable "tags" {
  type = object({
    Environment       = string
    Company           = string
    Deployment_Method = string
  })
}
variable "associate_public_ip_address" {
  type    = bool
  default = true
}