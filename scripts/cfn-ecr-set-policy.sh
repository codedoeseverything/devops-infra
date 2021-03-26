#!/usr/bin/env bash

NAME=$STACK_NAME-$ENV

sed -i "" "s/NAME/$NAME/g" ../current-iam-policy.json
sed -i "" "s/CURRENT/$CURRENTACCOUNTID/g" ../current-iam-policy.json
cat current-iam-policy.json

aws ecr set-repository-policy \
    --repository-name $ECR_REPONAME \
    --profile stage \
    --policy-text file://current-iam-policy.json >> /dev/null


