#!/bin/bash 

rm -rf temp; mkdir -p temp 1> /dev/null
aws s3 sync s3://$PRIVATES3BucketName/$STACK_NAME/$REGION/secrets/ temp/ --delete
S3KEYNAME=$(ls -l temp| awk '{print $9}')

for i in $S3KEYNAME ; do
  SECRETPREFIX=$(echo "$i" | cut -f 1 -d '.')
  SECRETNAME=$STACK_NAME-$SECRETPREFIX-$ENV
  echo "creating or updating secret for variable name "$SECRETNAME

  echo "checking if secret already exist"
  aws secretsmanager list-secrets --output text --query SecretList[*].Name | grep "$SECRETNAME" && export "ISEXIST"=true || export "ISEXIST"=false
  echo "secret name "$SECRETNAME" alreay exist :"$ISEXIST

  if [ "$ISEXIST" == "false" ]; then
        echo "creating new secret for variable name "$SECRETNAME
        echo $SECRETNAME=$(aws secretsmanager create-secret --name $SECRETNAME \
        --description "The secret name '"$SECRETNAME"' created with the Automation CLI" \
        --secret-string file://temp/$i \
        --query 'ARN' \
        --output text)>>secret.param
        $(aws secretsmanager tag-resource \
        --secret-id $SECRETNAME \
        --tags file://config/cfn-tags.json \
        --output text) 1> /dev/null
    else
        echo "updating existing secret for variable name "$SECRETNAME
        echo $SECRETNAME=$(aws secretsmanager update-secret \
        --description "The secret name '"$SECRETNAME"' created with the Automation CLI" \
        --secret-id $SECRETNAME \
        --secret-string file://temp/$i \
        --query 'ARN' \
        --output text)>>secret.param
    fi
done

sort -u secret.param | uniq -u > .env
rm secret.param


