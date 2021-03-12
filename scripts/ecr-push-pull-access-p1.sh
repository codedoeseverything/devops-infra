#!/usr/bin/env bash

ECR_REPONAME1=
sed -i "s/account-id/$CURRENTACCOUNTID/g" ecr-iam-policy.json
cat ecr-iam-policy.json

aws ecr set-repository-policy \
    --repository-name $ECR_REPONAME1 \
    --policy-text file://ecr-iam-policy.json