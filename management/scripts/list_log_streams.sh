#!/bin/bash
set -e
if test -f "env_variables.sh"; then
    source env_variables.sh
else 
    echo "no env_variables.sh file found"
    exit 1 
fi


echo "api streams: "
aws logs describe-log-streams --region $AWS_REGION --profile $PROFILE --descending --page-size 5 --max-items 5 --log-group-name "/ecs/${COMPANY_KEY}/${ENVIRONMENT_KEY}/${OUR_NAME}-api"
