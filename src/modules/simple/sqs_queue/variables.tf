variable "company_name" {
    type = string
}
variable "environment" {
    type = string
}
variable "name" {
    type = string
}
variable "tags" {
    type = object({
        Environment       = string
        Company           = string
        Deployment_Method = string
    })
}