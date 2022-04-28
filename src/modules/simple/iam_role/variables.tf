variable "company_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "policy" {
  type = string
}
variable "service" {
  type = string
}
variable "role_name" {
  type = string
}
variable "assume_role_conditions" {
  default = []
  type = list(object({
    test     = string
    variable = string
    values   = list(string)
  }))
}
variable "tags" {
  default = {}
  type = map(any)
}