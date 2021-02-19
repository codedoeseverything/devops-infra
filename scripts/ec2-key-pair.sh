#!/usr/bin/env bash

aws ec2 describe-key-pairs --key-name $EC2_KEY_PAIR --output text --region $REGION | grep $EC2_KEY_PAIR &> /dev/null
if [ $? == 0 ]
then
  echo $EC2_KEY_PAIR "Key pair already exist hence no need to re-create again"
else
  aws ec2 create-key-pair --key-name $EC2_KEY_PAIR --query 'KeyMaterial' --output text > $EC2_KEY_PAIR.pem
  aws s3 cp $EC2_KEY_PAIR.pem s3://$S3BucketNameKeyPair/$STACK_NAME/ec2-keys/ --acl bucket-owner-full-control
  echo $EC2_KEY_PAIR "successfully created and copied to centralized S3 bucket"
  rm $EC2_KEY_PAIR.pem
fi