variable "company_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "policy" {
  type = string
}
variable "role_name" {
  type = string
}
variable "external_aws_account_id" {
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