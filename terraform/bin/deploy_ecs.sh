#! /bin/bash

env_file=$1
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd "$SCRIPT_DIR/../ecs-app" || exit

terraform init \
  -backend-config "bucket=sliderule-tfstate" \
  -backend-config "region=us-west-1" \
  -backend-config "key=ecs-app/terraform.tfstate"
terraform workspace new "$env_file"
terraform workspace select "$env_file"

terraform apply -var-file="$env_file.tfvars"