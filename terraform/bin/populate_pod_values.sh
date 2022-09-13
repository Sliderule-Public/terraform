#! /bin/bash

ENVIRONMENT=$1
SECURITY_GROUP_ID=$2
TASK_IAM_ROLE=$3
ALB_CONTROLLER_IAM_ROLE=$4
CERT_ARN=$5
PUBLIC_SUBNET_IDS=$6
SERVICE_ACCOUNT_ROLE=$7

cp "../kubernetes-values.sample.yaml" "values-terraform-$ENVIRONMENT.yaml"

if [[ $OSTYPE == 'darwin'* ]]; then
  sed -i '' "s/pod_security_group:.*/pod_security_group: $SECURITY_GROUP_ID/" "values-terraform-$ENVIRONMENT.yaml"
  sed -i '' "s/service_account_role:.*/service_account_role: $TASK_IAM_ROLE/" "values-terraform-$ENVIRONMENT.yaml"
  sed -i '' "s/alb_controller_service_account_role:.*/alb_controller_service_account_role: $ALB_CONTROLLER_IAM_ROLE/" "values-terraform-$ENVIRONMENT.yaml"
  sed -i '' "s/alb_cert_arn:.*/alb_cert_arn: $CERT_ARN/" "values-terraform-$ENVIRONMENT.yaml"
  sed -i '' "s/public_subnet_ids:.*/public_subnet_ids: $PUBLIC_SUBNET_IDS/" "values-terraform-$ENVIRONMENT.yaml"
  sed -i '' "s/autoscaler_service_account_role:.*/autoscaler_service_account_role: $SERVICE_ACCOUNT_ROLE/" "values-terraform-$ENVIRONMENT.yaml"
else
  sed -i "s/pod_security_group:.*/pod_security_group: $SECURITY_GROUP_ID/" "values-terraform-$ENVIRONMENT.yaml"
  sed -i "s|service_account_role:.*|service_account_role: $TASK_IAM_ROLE|" "values-terraform-$ENVIRONMENT.yaml"
  sed -i "s|alb_controller_service_account_role:.*|alb_controller_service_account_role: $ALB_CONTROLLER_IAM_ROLE|" "values-terraform-$ENVIRONMENT.yaml"
  sed -i "s|alb_cert_arn:.*|alb_cert_arn: $CERT_ARN|" "values-terraform-$ENVIRONMENT.yaml"
  sed -i "s|public_subnet_ids:.*|public_subnet_ids: $PUBLIC_SUBNET_IDS|" "values-terraform-$ENVIRONMENT.yaml"
  sed -i "s|autoscaler_service_account_role:.*|autoscaler_service_account_role: $SERVICE_ACCOUNT_ROLE|" "values-terraform-$ENVIRONMENT.yaml"
fi

mv "values-terraform-$ENVIRONMENT.yaml" ../../kubernetes/aws/shieldrule