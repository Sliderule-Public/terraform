variable "environment" {
  type = string
}
variable "image_tag" {
  type = string
}
variable "company_name" {
  type = string
}
variable "region" {
  type = string
}
variable "task_name" {
  type = string
}
variable "account_id" {
  type = string
}
variable "image_name" {
  type = string
}
variable "cpu" {
  type = number
}
variable "memory" {
  type = number
}
variable "container_port" {
  type = number
}
variable "execution_role_arn" {
  type = string
}
variable "task_role_arn" {
  type = string
}
variable "command" {
  type    = list(string)
  default = ["npm", "run", "release"]
}
variable "linuxParameters" {
  type = object({
    tmpfs = list(object({
      containerPath = string
      size          = number
      mountOptions  = list(string)
    }))
  })
}
variable "environmentOverrides" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}
variable "environmentFiles" {
  type = list(object({
    type  = string
    value = string
  }))
  default = []
}
variable "tags" {
  type = object({
    Environment       = string
    Company           = string
    Deployment_Method = string
  })
}
variable "read_only" {
  type    = bool
  default = true
}
variable "user" {
  type = string
}
variable "kms_key_arn" {
  type = string
}
variable "additional_api_ports" {
  type = list(object({
    port = number
    name = string
    health_check_route = string
  }))
  default = []
}
