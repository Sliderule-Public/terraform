variable "company_name" {
    type = string
}
variable "environment" {
    type = string
}
variable "profile_name" {
    type = string
}
variable "role_name" {
    type = string
}
variable "tags" {
    type = object({
        Environment       = string
        Company           = string
        Deployment_Method = string
    })
}