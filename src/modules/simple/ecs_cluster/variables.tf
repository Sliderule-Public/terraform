variable "environment" {
  type = string
}
variable "company_name" {
  type = string
}
variable "cluster_name" {
  type = string
}
variable "autoscaling_group_arn" {
  type = string
  default = ""
}
variable "tags" {
  type = object({
    Environment       = string
    Company           = string
    Deployment_Method = string
  })
}