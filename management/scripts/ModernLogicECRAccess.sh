#!/bin/bash
set -e
if test -f "env_variables.sh"; then
    source env_variables.sh
else 
    echo "no env_variables.sh file found"
    exit 1 
fi


cat > ECRPolicy.json << EndOfMessage
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:BatchCheckLayerAvailability",
                "ecr:BatchDeleteImage",
                "ecr:BatchGetImage",
                "ecr:CompleteLayerUpload",
                "ecr:Describe*",
                "ecr:Get*",
                "ecr:InitiateLayerUpload",
                "ecr:ListImages",
                "ecr:ListTagsForResource",
                "ecr:PutImage",
                "ecr:ReplicateImage",
                "ecr:StartImageScan",
                "ecr:TagResource",
                "ecr:UntagResource",
                "ecr:UploadLayerPart"
            ],
            "Resource": [
                "arn:aws:ecr:*:ACCOUNT_ID:repository/${OUR_NAME}-api",
                "arn:aws:ecr:*:ACCOUNT_ID:repository/${OUR_NAME}-docs",
                "arn:aws:ecr:*:ACCOUNT_ID:repository/${OUR_NAME}-web",
                "arn:aws:ecr:*:ACCOUNT_ID:repository/prometheus"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}

EndOfMessage
