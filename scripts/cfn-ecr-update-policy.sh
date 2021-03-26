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

    python3 scripts/cfn-ecr-policy.py

    sed -i "s/NAME/$NAME/g" current-iam-policy.json
    sed -i "s/CURRENT/$CURRENTACCOUNTID/g" current-iam-policy.json

    cat current-iam-policy.json

    aws ecr set-repository-policy \
        --repository-name $ECR_REPONAME \
        --policy-text file://current-iam-policy.json >> /dev/null

fi


