#!/bin/bash
set -e
if test -f "env_variables.sh"; then
    source env_variables.sh
else 
    echo "no env_variables.sh file found"
    exit 1 
fi

if test -f "${HOME}/.secrets/${COMPANY_KEY}_${ENVIRONMENT_KEY}/secrets.sh"; then
    source "${HOME}/.secrets/${COMPANY_KEY}_${ENVIRONMENT_KEY}/secrets.sh"
fi

ssh -i "~/.ssh/${SSH_KEY}" "ec2-user@${BASTION_IP}"


