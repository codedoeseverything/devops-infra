#!/usr/bin/env bash

ssm_param=$(aws --region=ap-southeast-2 ssm get-parameter \
--name $SSM_VAR --with-decryption \
--output text --query Parameter.Value)

cat >>config/cfn.params <<EOF 
$ssm_param
EOF