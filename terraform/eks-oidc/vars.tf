variable "aws_region" {
  type        = string
  description = "AWS region to deploy into"
}
variable "k8s_namespace" {
  type        = string
  description = "kubernetes namespace to set the role for. For this stack, it should be the same as the environment passed to eks-app."
}
variable "role_arn" {
  type        = string
  description = "AWS ARN of module.eks_task_role from the eks-app stack deployed in step 1"
}
variable "cluster_id" {
  type        = string
  description = "cluster id of the EKS cluster to use"
}
variable "certificate_data" {
  type        = string
  description = "certificate data for the ECS cluster. In terraform it can be found at aws_eks_cluster.{your_cluster}.certificate_authority[0].data"
}
variable "role_name" {
  type        = string
  description = "Name of the role made by module.eks_task_role from the eks-app stack deployed in step 1"
}
variable "issuer" {
  type        = string
  description = "OICD issuer for the EKS cluster, optionally from step 1. In terraform it can be found at aws_eks_cluster.{your_cluster}.identity[0].oidc[0].issuer"
}
variable "endpoint" {
  type        = string
  description = "OICD issuer for the EKS cluster, optionally from step 1. In terraform it can be found at aws_eks_cluster.{your_cluster}.endpoint"
}
