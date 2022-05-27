#!/bin/bash
set -e
if test -f "env_variables.sh"; then
    source env_variables.sh
else 
    echo "no env_variables.sh file found"
    exit 1 
fi


aws s3 cp "${ENVIRONMENT_KEY}.env" "s3://${COMPANY_KEY}-${ENVIRONMENT_KEY}-infrastructure/env-files/api/${ENVIRONMENT_KEY}.env" 
