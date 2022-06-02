#! /bin/bash

ENVIRONMENT="$1"
aws_region="$2"
role_arn="$3"
role_name="$4"

cp "../eks-oidc-vars.sample" "eks-oidc-$ENVIRONMENT.tfvars"

if [[ $OSTYPE == 'darwin'* ]]; then
  sed -i '' "s/aws_region=.*/aws_region= \"$aws_region\"/" "eks-oidc-$ENVIRONMENT.tfvars"
  sed -i '' "s/k8s_namespace=.*/k8s_namespace= \"$ENVIRONMENT\"/" "eks-oidc-$ENVIRONMENT.tfvars"
  sed -i '' "s|role_arn=.*|role_arn= \"$role_arn\"|" "eks-oidc-$ENVIRONMENT.tfvars"
  sed -i '' "s/role_name=.*/role_name= \"$role_name\"/" "eks-oidc-$ENVIRONMENT.tfvars"
else
  sed -i "s/aws_region=.*/aws_region= \"$aws_region\"/" "eks-oidc-$ENVIRONMENT.tfvars"
  sed -i "s/k8s_namespace=.*/k8s_namespace= \"$ENVIRONMENT\"/" "eks-oidc-$ENVIRONMENT.tfvars"
  sed -i "s|role_arn=.*|role_arn= \"$role_arn\"|" "eks-oidc-$ENVIRONMENT.tfvars"
  sed -i "s/role_name=.*/role_name= \"$role_name\"/" "eks-oidc-$ENVIRONMENT.tfvars"
fi

mv "eks-oidc-$ENVIRONMENT.tfvars" "../eks-oidc/$ENVIRONMENT.tfvars"