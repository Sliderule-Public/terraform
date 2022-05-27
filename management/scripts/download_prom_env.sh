#!/bin/bash
set -e
if test -f "env_variables.sh"; then
    source env_variables.sh
else 
    echo "no env_variables.sh file found"
    exit 1 
fi


aws s3 cp "s3://${COMPANY_KEY}-${ENVIRONMENT_KEY}-infrastructure/env-files/prometheus/${ENVIRONMENT_KEY}.env" "./prom-${ENVIRONMENT_KEY}.env"
