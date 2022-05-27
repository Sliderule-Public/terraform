#!/bin/bash
set -e
if test -f "env_variables.sh"; then
    source env_variables.sh
else 
    echo "no env_variables.sh file found"
    exit 1 
fi

ssh -i "~/.ssh/${SSH_KEY}" -L "1112:${REDIS_URL}:6379" "ec2-user@${BASTION_IP}"


