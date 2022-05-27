#!/bin/bash
set -e
if test -f "env_variables.sh"; then
    source env_variables.sh
else 
    echo "no env_variables.sh file found"
    exit 1 
fi


aws ecs update-service --region $AWS_REGION --profile $PROFILE --cluster "${COMPANY_KEY}-${ENVIRONMENT_KEY}-services" --service "${COMPANY_KEY}-${ENVIRONMENT_KEY}-${OUR_NAME}-api" --force-new-deployment
aws ecs update-service --region $AWS_REGION --profile $PROFILE --cluster "${COMPANY_KEY}-${ENVIRONMENT_KEY}-services" --service "${COMPANY_KEY}-${ENVIRONMENT_KEY}-${OUR_NAME}-web" --force-new-deployment

