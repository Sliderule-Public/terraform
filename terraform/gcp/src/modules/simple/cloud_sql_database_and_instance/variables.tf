variable "environment" {
  type = string
}
variable "app_name" {
  type = string
}
variable "project_id" {
  type = string
}
variable "db_name" {
  type = string
}
variable "db_tier" {
  type = string
  default = "db-f1-micro"
}
variable "db_version" {
  type = string
  default = "POSTGRES_11"
}
variable "network_id" {
  type = string
}