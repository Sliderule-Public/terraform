#!/bin/bash
set -e
if test -f "env_variables.sh"; then
    source env_variables.sh
else 
    echo "no env_variables.sh file found"
    exit 1 
fi

aws ecs describe-tasks --region $AWS_REGION --profile $PROFILE --cluster "${COMPANY_KEY}-${ENVIRONMENT_KEY}-services" --tasks $1



