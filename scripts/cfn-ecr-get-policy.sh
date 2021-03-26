#!/usr/bin/env bash

aws ecr get-repository-policy \
    --repository-name $ECR_REPONAME \
    --profile stage | \
    jq -r '.policyText'> current-iam-policy.json



