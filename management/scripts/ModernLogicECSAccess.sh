#!/bin/bash
set -e
if test -f "env_variables.sh"; then
    source env_variables.sh
else 
    echo "no env_variables.sh file found"
    exit 1 
fi


cat > ECSPolicy.json << EndOfMessage
{
    "Statement": [
        {
            "Action": [
                "ecs:*"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:ecs:${AWS_REGION}:ACCOUNT_ID:cluster/${COMPANY_KEY}-${ENVIRONMENT_KEY}-services",
                "arn:aws:ecs:${AWS_REGION}:ACCOUNT_ID:cluster/${COMPANY_KEY}-${ENVIRONMENT_KEY}-services"
            ]
        },
        {
            "Action": [
                "ecs:DescribeContainerInstances",
                "ecs:DescribeTasks",
                "ecs:ListTasks",
                "ecs:RunTask",
                "ecs:StartTask",
                "ecs:StopTask",
                "ecs:UpdateContainerAgent",
                "ecs:UpdateService"
            ],
            "Condition": {
                "ForAnyValue:ArnEquals": {
                    "ecs:cluster": [
                        "arn:aws:ecs:${AWS_REGION}:ACCOUNT_ID:cluster/${COMPANY_KEY}-${ENVIRONMENT_KEY}-services",
                        "arn:aws:ecs:${AWS_REGION}:ACCOUNT_ID:cluster/${COMPANY_KEY}-${ENVIRONMENT_KEY}-services"
                    ]
                }
            },
            "Effect": "Allow",
            "Resource": "*"
        }
    ],
    "Version": "2012-10-17"
}

EndOfMessage
