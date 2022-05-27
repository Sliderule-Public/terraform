#! /bin/bash

ENVIRONMENT=$1
SECURITY_GROUP_ID=$2
IAM_ROLE=$3

cp "../kubernetes-values.sample.yaml" "values-terraform-$ENVIRONMENT.yaml"

if [[ $OSTYPE == 'darwin'* ]]; then
  sed -i '' "s/pod_security_group:.*/pod_security_group: $SECURITY_GROUP_ID/" "values-terraform-$ENVIRONMENT.yaml"
else
  sed -i "s/pod_security_group:.*/pod_security_group: $SECURITY_GROUP_ID/" "values-terraform-$ENVIRONMENT.yaml"
fi

mv "values-terraform-$ENVIRONMENT.yaml" ../../kubernetes/aws/shieldrule