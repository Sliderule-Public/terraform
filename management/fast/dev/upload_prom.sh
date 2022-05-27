#!/bin/bash
set -e
if test -f "env_variables.sh"; then
    source env_variables.sh
else 
    echo "no env_variables.sh file found"
    exit 1 
fi



aws ecr get-login-password --region $AWS_REGION --profile $PROFILE | docker login --username AWS --password-stdin "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/prometheus"


docker pull "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/prometheus:prod" 

docker tag  "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/prometheus:prod" "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/prometheus:dev"

docker push "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/prometheus:dev" 

