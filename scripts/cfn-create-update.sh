#!/bin/bash 
STACKNAME="vpc1"
bash ./cfn-deploy.sh \
"ap-southeast-2" \
$STACKNAME \
"default" \
--template-body file://../cfn-templates/main.yml \
--parameters file://../config/param.json \
--capabilities=CAPABILITY_NAMED_IAM