#! /bin/bash

ENVIRONMENT=$1
DATABASE_ENDPOINT=$2
DATABASE_USER=$3
DATABASE_PASSWORD=$4
DATABASE_NAME=$5
DATABASE_PORT=$6
COMPANY_NAME=$7
AUTH0_PASSWORD=$8

aws ssm send-command \
    --document-name "AWS-RunShellScript" \
    --parameters "commands=['PGPASSWORD=$DATABASE_PASSWORD psql -U $DATABASE_USER -h $DATABASE_ENDPOINT $DATABASE_NAME -c \"CREATE ROLE auth0 LOGIN PASSWORD \'$AUTH0_PASSWORD\'\"']" \
    --targets "Key=tag:Name,Values=$COMPANY_NAME-$ENVIRONMENT-bastion" \
    --comment "create auth0 user in psql database"