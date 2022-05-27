variable "environment" {
  type = string
}
variable "app_name" {
  type = string
}
variable "project_id" {
  type = string
}
variable "location" {
  type = string
  default = "us-west1"
}
variable "image" {
  type = string
}
variable "image_tag" {
  type = string
}