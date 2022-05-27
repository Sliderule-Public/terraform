variable "company_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "log_group_name" {
  type    = string
  default = ""
}
variable "pattern" {
  type    = string
  default = ""
}
variable "namespace" {
  type = string
}
variable "module_name" {
  type = string
}
variable "metric_name" {
  type = string
}
variable "alarm_actions" {
  type = list(string)
}
variable "evaluation_periods" {
  type    = string
  default = "1"
}
variable "period" {
  type    = string
  default = "300"
}
variable "statistic" {
  type    = string
  default = "Sum"
}
variable "comparison_operator" {
  type    = string
  default = "GreaterThanOrEqualToThreshold"
}
variable "target_group_arn" {
  type    = string
}
variable "load_balancer_arn" {
  type    = string
}