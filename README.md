# Infrastructure readme

## Details
This stack uses Terraform 0.15.0 to launch all infrastructure resources needed to host the Shieldrule suite in ECS or EKS.
The major pieces this stack deploys per environment are:
- VPC / subnets / route tables / NAT gateway / internet gateway / ACLs
- ECS host autoscaling group
- Public-facing load balancer
- Optional ECS cluster
- ECS services for each app
- Route 53 DNS entries for each app


## Structure
TL;DR The `/eks-app` directory will be your main focus. It houses all the important terraform files for managing your Modern Logic app's resources. The `/shared` directory manages ancillary dependencies for the app directory. These resources can be easily substituted for ones that your orginization already manages. The `/src` directory is only for modules used by the other two directories. You should never have to work directly with anything in this folder.

Here are the main directories and their purposes:
- `/shared` - hosts one-time resources that are shared across application deployments, such as AWS ECR repositories, optional Route53 resources, and an ECS service role.
You should never have to interact with this directory outside of a single one-time `terraform apply` at the beginning of your onboarding.
- `/ecs-app` - hosts the actual terraform you'll run `terraform apply` in to deploy the Shieldrule application in ECS. This directory has *.tf files which handle all the resources required for Shieldrule.
- `/eks-app` - an alternative to `ecs-app` for those who want to deploy EKS instead.
- `/src` - contains terraform modules. This directory exists to create consistency among all terraform resources deployed, and is used by the `/ecs-app` and `eks-app` directories in the form of module calls.
You should never have to interact with this directory or any subdirectories inside it.


## One-time Prerequisites

### Deploying the shared stack
- Configure an AWS profile or credentials
- Copy `shared/sample.tfvars` to `shared/default.tfvars`
- Fill out variables in `shared/default.tfvars`
- `cd shared`
- `terraform apply --var-file=default.tfvars`

### Creating an AWS ACM certificate
This is done manually in order to allow you to use any DNS provider and verification method your team supports to create a certificate.

- Visit the AWS ACM dashboard and make a single certificate for the values `yourdomain.com` and `*.yourdomain.com`
- Validate the certificate any way you need


### Terraform Backend Configuration
- Fill out the `terraform.backend` section in `app/main.tf`, or otherwise set your preferred backend

## Creating a new environment
### ECS
#### Setup steps
- Copy `ecs-app/sample.tfvars` to `ecs-app/{environment}.tfvars` file, and fill in required values
- If you're not using Route 53, set `deploy_route53_resources = false` in `app/{environment}.tfvars`
- Create a `{company}-services-{environment}.pem` key pair in AWS in the desired region
- Deploy:
  ```
  cd ecs-app
  terraform workspace new {env}
  terraform init
  terraform apply --var-file={env}.tfvars
  ```

#### EKS inside `ecs-app`
Because `ecs-app` and `eks-app` are mutually-exclusive Terraform stacks, and because of the need for some to be able to use both ECS and EKS, or switch between them, `ecs-app` offers an optional EKS cluster.

There are two flows for deploying the optional EKS cluster from `ecs-app`:


### EKS
#### Setup
- Copy `eks-app/sample.tfvars` to `eks-app/{environment}.tfvars` file, and fill in required values
- Deploy:
  ```
  cd eks-app
  terraform workspace new {env}
  terraform init
  terraform apply --var-file={env}.tfvars
  ```
- this stack will create all resources needed to host Shieldrule in EKS, and then output required values to `kubernetes/aws/shieldrule` to simplify deployments in those stacks

#### Kubernetes deployment
#### Deployment types
We offer two kinds of deployments without any additional customization: NodePort and AWS ALB Ingress. Choose NodePort if you plan to handle your own ingress.
Choose AWS ALB Ingress if you want the helm chart to expose your services through an AWS Application Load Balancer.
- If you set `var.use_variable_scripts` in `eks-app` to false, you'll need to generate a values file. Copy `infrastructure/kubernetes/aws/shieldrule/values.sample.yaml` to `values-${environment}.yaml` and customize it.


##### Basic NodePort deployment
- Set `enable_aws_alb` to false in your values file if you want to prevent deployment of AWS ALB resources
- Run `use_aws_cluster region=${aws region} cluster=${EKS cluster}` to configure kubectl access
- Run `make install` in `infrastructure/kubernetes/aws/shieldrule`

##### ALB Ingress deployment
- Set `enable_aws_alb` to true in your values file
- Set `alb_controller_service_account_role` to the value of the `EKS_ALB_CONTROLLER_ROLE_ARN` output in the `eks-app` Terraform stack.
- Run `use_aws_cluster region=${aws region} cluster=${EKS cluster}` to configure kubectl access
- Run `make install_all` in `infrastructure/kubernetes/aws/shieldrule`

##### Other considerations
We offer a few small scripts in `infrastructure/kubernetes/aws/shieldrule/Makefile` to make it easier to deploy our kubernetes manifests. Some useful scripts:
- `use_aws_cluster`: pass an AWS region and a cluster name to configure kubectl context for a cluster
- `install`: deploy the helm chart, without deploying the ALB controller service account or actual controller
- `install_all`: deploy the helm chart in addition to a service account and ALB controller, for ALB ingress
- `add_prerequisites` covered by `install_all`. Launches prerequisites into kubernetes. Currently, it's only a service account for the ALB controller.
- `add_alb_controller` covered by `install_all`. Launches prerequisites into kubernetes. Launches an ALB controller into the `kube-system` namespace.
- In order to accommodate as many environment setups as possible, we've tried to minimize the complexity of our Kubernetes deployment. View our [shared responsibility doc](shared_responsibility.md) for more information.