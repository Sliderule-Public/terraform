AWS_ID := $(shell aws sts get-caller-identity --query 'Account' | tr -d '"')
current_dir = $(shell pwd)

.ONESHELL:
deploy_ecs:
		cd ecs-app
		terraform init -upgrade \
		    -backend-config "bucket=modernlogic-terraform-state-$(env)" \
			-backend-config "region=us-west-1" \
			-backend-config "key=$(env)/terraform.tfstate"
		terraform workspace new $(env)
		terraform workspace select $(env)
		terraform apply -var-file="$(env).tfvars"

deploy_eks:
		cd $(current_dir)/eks-app
		terraform init -upgrade \
		    -backend-config "bucket=modernlogic-terraform-state-$(env)" \
			-backend-config "region=us-west-1" \
			-backend-config "key=eks/$(env)/terraform.tfstate"
		terraform workspace new $(env)
		terraform workspace select $(env)
		terraform apply -var-file="$(env).tfvars" -lock=false

deploy_eks_oidc:
		cd $(current_dir)/eks-oidc
		terraform init -upgrade \
			-backend-config "bucket=modernlogic-terraform-state-$(env)" \
			-backend-config "region=us-west-1" \
			-backend-config "key=eks-oicd/$(env)/terraform.tfstate"
		terraform workspace new $(env)
		terraform workspace select $(env)
		terraform apply -var-file="$(env).tfvars" -lock=false

.ONESHELL:
deploy_shared:
		cd shared
		terraform init -upgrade \
		    -backend-config "bucket=modernlogic-terraform-state-$(env)" \
			-backend-config "region=us-west-1" \
			-backend-config "key=shared/terraform.tfstate"
		terraform apply -var-file="default.tfvars"

.ONESHELL:
deploy_shieldrule_specific:
		cd shieldrule-specific
		terraform init
		terraform apply -var-file="default.tfvars"
