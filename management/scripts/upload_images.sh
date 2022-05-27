#!/bin/bash
set -e
if test -f "env_variables.sh"; then
    source env_variables.sh
else 
    echo "no env_variables.sh file found"
    exit 1 
fi


aws ecr get-login-password --region us-west-1 | docker login --username AWS --password-stdin  600592424179.dkr.ecr.us-west-1.amazonaws.com/shieldrule-web
aws ecr get-login-password --region us-west-1 | docker login --username AWS --password-stdin  600592424179.dkr.ecr.us-west-1.amazonaws.com/shieldrule-api
aws ecr get-login-password --region us-west-1 | docker login --username AWS --password-stdin  600592424179.dkr.ecr.us-west-1.amazonaws.com/prometheus


aws ecr get-login-password --region $AWS_REGION --profile $PROFILE | docker login --username AWS --password-stdin "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${OUR_NAME}-api"

aws ecr get-login-password --region $AWS_REGION --profile $PROFILE | docker login --username AWS --password-stdin "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${OUR_NAME}-web"
aws ecr get-login-password --region $AWS_REGION --profile $PROFILE | docker login --username AWS --password-stdin "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/prometheus"


docker pull 600592424179.dkr.ecr.us-west-1.amazonaws.com/shieldrule-web:master
docker pull 600592424179.dkr.ecr.us-west-1.amazonaws.com/shieldrule-api:master
docker pull 600592424179.dkr.ecr.us-west-1.amazonaws.com/prometheus:prod


docker tag 600592424179.dkr.ecr.us-west-1.amazonaws.com/shieldrule-api:master "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${OUR_NAME}-api:${ENVIRONMENT_KEY}"
docker tag 600592424179.dkr.ecr.us-west-1.amazonaws.com/shieldrule-api:master "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${OUR_NAME}-api:master"
docker tag 600592424179.dkr.ecr.us-west-1.amazonaws.com/shieldrule-web:master "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${OUR_NAME}-web:${ENVIRONMENT_KEY}"
docker tag 600592424179.dkr.ecr.us-west-1.amazonaws.com/shieldrule-web:master "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${OUR_NAME}-web:master"

docker tag 600592424179.dkr.ecr.us-west-1.amazonaws.com/prometheus:prod "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/prometheus:${ENVIRONMENT_KEY}"

docker push "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${OUR_NAME}-api:${ENVIRONMENT_KEY}"
docker push "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${OUR_NAME}-api:master"
docker push "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${OUR_NAME}-web:${ENVIRONMENT_KEY}"
docker push "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${OUR_NAME}-web:master"

docker push "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/prometheus:${ENVIRONMENT_KEY}"


