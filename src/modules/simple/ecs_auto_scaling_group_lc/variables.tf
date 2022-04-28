variable "environment" {
  type = string
}
variable "company_name" {
  type = string
}
variable "group_name" {
  type = string
}
variable "launch_configuration_name" {
  type = string
}
variable "region" {
  type = string
}
variable "desired_count" {
  type = number
  default = 0
}
variable "set_count" {
  type    = bool
  default = false
}
variable "max_count" {
  type = number
}
variable "subnets" {
  type = list(string)
}
variable "min" {
  type = number
  default = 0
}
variable "tags" {
  type = object({
    Environment       = string
    Company           = string
    Deployment_Method = string
  })
}