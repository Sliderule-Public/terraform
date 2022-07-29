# Kubernetes Shared Responsibility

In order to reduce complexity and accommodate as many different AWS setups as possible, we've intentionally not included some features in our Kubernetes manifests.
We expect that people will need to fork and modify this setup to meet their own team's needs.

## What we deploy

### Terraform
- optional VPC
- optional EKS cluster and node group
- IAM rules for Kubernetes service accounts
- Various storage, data and encryption layer resources needed to support the app


### Kubernetes
- optional AWS ALB service account and ALB controller
- a deployment and NodePort service for the API
- An exposed port for a GRPC connection to the API
- a deployment and NodePort service for the Web service
- Basic secrets management for API env vars
- Optional AWS ALB Ingress resources for the API and Web service

## What we don't include
- Secrets management through any AWS or third-party service
- Other types of Kubernetes service other than NodePort
- Logging, monitoring or alerting setups through any AWS or third-party service
- CI/CD for Kubernetes or built-in complex release systems
- Cluster administration