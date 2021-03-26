#!/usr/bin/env bash

NAME=AllowECRAccess-$STACK_NAME-$ENV

aws ecr get-repository-policy \
    --repository-name $ECR_REPONAME | \
    grep $NAME &> /dev/null

if [ $? == 0 ]
then
    echo $NAME "ECR IAM Policy already exist hence no need to re-create again"
else
    aws ecr get-repository-policy \
    --repository-name $ECR_REPONAME | \
    jq -r '.policyText'> current-iam-policy.json
fi

python3 --version
