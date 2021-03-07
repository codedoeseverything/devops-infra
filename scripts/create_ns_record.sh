#!/usr/bin/env bash

# aws ec2 describe-key-pairs --key-name $EC2KEYPAIR --output text --region $REGION | grep $EC2KEYPAIR &> /dev/null
# if [ $? == 0 ]
# then
#   echo $EC2KEYPAIR "Key pair already exist hence no need to re-create again"
# else
#   aws ec2 create-key-pair --key-name $EC2KEYPAIR --query 'KeyMaterial' --output text > $EC2KEYPAIR.pem
#   aws s3 cp $EC2KEYPAIR.pem s3://$S3BucketNameKeyPair/$STACK_NAME/ec2-keys/ --acl bucket-owner-full-control
#   echo $EC2KEYPAIR "successfully created and copied to centralized S3 bucket"
#   rm $EC2KEYPAIR.pem
# fi



PublicHostedZoneName=sub.quicktest.com 
PublicHostedZoneId=Z02869401EGHOT9UP36YF
PublicHostedZoneNSRecord=ns-553.awsdns-05.net,ns-1306.awsdns-35.org,ns-1586.awsdns-06.co.uk,ns-282.awsdns-35.com

# Creates route 53 records based on env name

aws route53 change-resource-record-sets --hosted-zone-id $PublicHostedZoneId \
--change-batch '{ "Comment": "Testing creating a record set", \
"Changes": [ { "Action": "CREATE", "ResourceRecordSet": { "Name": \
"`"$PublicHostedZoneName"`", "Type": "CNAME", "TTL": \
120, "ResourceRecords": [ { "Value": "`"$PublicHostedZoneNSRecord"`" } ] } } ] }'