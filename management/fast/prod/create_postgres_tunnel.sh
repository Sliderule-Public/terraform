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

ssh -i "~/.ssh/${SSH_KEY}" -L "1111:${POSTGRES_URL}:5432" "ec2-user@${BASTION_IP}"

