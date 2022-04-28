variable "target" {
  type = string
}
variable "zone_id" {
  type = string
}
variable "target_zone_id" {
  type = string
}
variable "name" {
  type = string
}
variable "type" {
  type    = string
  default = "A"
}
variable "tags" {
  type = object({
    Environment       = string
    Company           = string
    Deployment_Method = string
  })
}