#!/bin/bash
set -e
if test -f "env_variables.sh"; then
    source env_variables.sh
else 
    echo "no env_variables.sh file found"
    exit 1 
fi


aws sts assume-role --external-id $EXTERNAL_ID --role-arn "arn:aws:iam::${AWS_ACCOUNT_ID}:role/${NAME_OF_ROLE}" --role-session-name "FirstTime" --profile default 

