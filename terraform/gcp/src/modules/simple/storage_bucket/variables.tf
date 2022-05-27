variable "environment" {
  type = string
}
variable "app_name" {
  type = string
}
variable "project_id" {
  type = string
}
variable "bucket_name" {
  type = string
}
variable "uniform_bucket_level_access" {
  type = bool
  default = true
}