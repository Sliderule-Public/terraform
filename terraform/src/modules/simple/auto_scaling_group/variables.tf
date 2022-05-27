variable "environment" {
  type = string
}
variable "company_name" {
  type = string
}
variable "group_name" {
  type = string
}
variable "launch_template_id" {
  type = string
}
variable "region" {
  type = string
}
variable "desired_count" {
  type = number
}
variable "set_count" {
  type    = bool
  default = false
}
variable "max_count" {
  type = number
}
variable "min" {
  type = number
}
variable "subnets" {
  type = list(string)
}
variable "tags" {
  type = object({
    Environment       = string
    Company           = string
    Deployment_Method = string
  })
}
