#! /bin/bash

ENVIRONMENT=$1
ALB_CONTROLLER_IAM_ROLE=$2
SERVICE_ACCOUNT_ROLE=$3

cp "../kubernetes-prerequisites-values.sample.yaml" "values-prerequisites-$ENVIRONMENT.yaml"

if [[ $OSTYPE == 'darwin'* ]]; then
  sed -i '' "s/clusterName:.*/clusterName: $ENVIRONMENT-eks/" "values-prerequisites-$ENVIRONMENT.yaml"
  sed -i '' "s/alb_controller_service_account_role:.*/alb_controller_service_account_role: $ALB_CONTROLLER_IAM_ROLE/" "values-prerequisites-$ENVIRONMENT.yaml"
  sed -i '' "s/autoscaler_service_account_role:.*/autoscaler_service_account_role: $SERVICE_ACCOUNT_ROLE/" "values-prerequisites-$ENVIRONMENT.yaml"
  sed -i '' "s/shieldrule_environment:.*/shieldrule_environment: $ENVIRONMENT/" "values-prerequisites-$ENVIRONMENT.yaml"
else
  sed -i "s/clusterName:.*/clusterName: $ENVIRONMENT-eks/" "values-prerequisites-$ENVIRONMENT.yaml"
  sed -i "s|alb_controller_service_account_role:.*|alb_controller_service_account_role: $ALB_CONTROLLER_IAM_ROLE|" "values-prerequisites-$ENVIRONMENT.yaml"
  sed -i "s|autoscaler_service_account_role:.*|autoscaler_service_account_role: $SERVICE_ACCOUNT_ROLE|" "values-prerequisites-$ENVIRONMENT.yaml"
  sed -i "s|shieldrule_environment:.*|shieldrule_environment: $ENVIRONMENT|" "values-prerequisites-$ENVIRONMENT.yaml"
fi

mv "values-prerequisites-$ENVIRONMENT.yaml" ../../kubernetes/aws/prerequisites