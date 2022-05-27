#!/bin/bash
set -e
if test -f "env_variables.sh"; then
    source env_variables.sh
else 
    echo "no env_variables.sh file found"
    exit 1 
fi

if test -f "secrets.sh"; then
    source secrets.sh
fi

aws s3 cp "s3://${COMPANY_KEY}-${ENVIRONMENT_KEY}-infrastructure/env-files/api/${ENVIRONMENT_KEY}.env" .
