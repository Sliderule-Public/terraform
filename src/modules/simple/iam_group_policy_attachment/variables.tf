variable "group_name" {
    type = string
}
variable "policy_arn" {
    type = string
}
variable "tags" {
    type = object({
        Environment       = string
        Company           = string
        Deployment_Method = string
    })
}