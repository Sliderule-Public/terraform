#!/bin/bash
set -e
if test -f "env_variables.sh"; then
    source env_variables.sh
else 
    echo "no env_variables.sh file found"
    exit 1 
fi


 cat > CloudWatchPolicy.json << EndOfMessage
{
    "Statement": [
        {
            "Action": [
                "logs:Describe*",
                "logs:Get*",
                "logs:List*",
                "logs:StartQuery",
                "logs:StopQuery",
                "logs:TestMetricFilter",
                "logs:FilterLogEvents"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:${AWS_REGION}:ACCOUNT_ID:log-group:/ecs/${COMPANY_KEY}/${ENVIRONMENT_KEY}/${OUR_NAME}*"
            ]
        }
    ],
    "Version": "2012-10-17"
}

EndOfMessage
