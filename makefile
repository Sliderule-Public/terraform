AWS_ID := $(shell aws sts get-caller-identity --query 'Account' | tr -d '"')

.ONESHELL:
deploy:
		@echo "Deploying..."
		cd app
		terraform init -upgrade \
		    -backend-config "bucket=modernlogic-terraform-state-$(env)" \
			-backend-config "region=us-west-1" \
			-backend-config "key=$(env)/terraform.tfstate"
		terraform workspace new $(env)
		terraform workspace select $(env)
		terraform apply -var-file="$(env).tfvars"

.ONESHELL:
deploy_shared:
		@echo "Deploying..."
		cd shared
		terraform init -upgrade \
		    -backend-config "bucket=modernlogic-terraform-state-$(env)" \
			-backend-config "region=us-west-1" \
			-backend-config "key=shared/terraform.tfstate"
		terraform apply -var-file="default.tfvars"

.ONESHELL:
deploy_shieldrule_specific:
		@echo "Deploying..."
		cd shieldrule-specific
		terraform init
		terraform apply -var-file="default.tfvars"
