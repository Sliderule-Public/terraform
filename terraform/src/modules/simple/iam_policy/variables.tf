variable "app_name" {
    type = string
}
variable "company_name" {
    type = string
}
variable "environment" {
    type = string
}
variable "policy" {
    type = string
}
variable "policy_name" {
    type = string
}
variable "tags" {
    type = object({
        Environment       = string
        Company           = string
        Deployment_Method = string
    })
}