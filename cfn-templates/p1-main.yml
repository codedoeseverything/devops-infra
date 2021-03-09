AWSTemplateFormatVersion: '2010-09-09'

Description: This is P1 AWS dependency creation master cloudformation template for core Practera infrastructure
  design

Metadata:
  Authors:
    Description: Sunil and Mihai (sunil@practera.com/mihai@practera.com) based on
      AWS quickstart/widdix and best practise.
  License:
    Description: Copyright 2020 Intersective PTY LTD and its affiliates. All Rights
      Reserved.

Parameters:

  CFNS3BucketName:
    Description: S3 bucket name for the Cloudformation template stored. This string
      can include numbers, lowercase letters, uppercase letters, and hyphens (-).
      It cannot start or end with a hyphen (-).
    Default: devops-cfn-templates
    Type: String
  CFNS3BucketRegion:
    Default: ap-southeast-2
    Description: The AWS Region where the Cloudformation template stored in S3 bucket
      is hosted. When using your own bucket, you must specify this value.
    Type: String
  StackName:
    ConstraintDescription: This will be unique string to represent our stack.
    Default: beta
    Description: A client/project/product unique name for the stack to idnetify later.
      This string can include numbers, lowercase letters, uppercase letters, and hyphens
      (-). It cannot start or end with a hyphen (-).
    Type: String
    AllowedValues: [au,us,uk,p2,lf,nu,alpha,beta]
  Env:
    Description: Environment type.
    Default: stage
    Type: String
    AllowedValues:
      - sandbox
      - stage
      - live
    ConstraintDescription: must specify sandbox,stage,live.
  ParentHostedZoneName:
    Description: 'The name of the parent hosted zone.'
    Type: String
  ParentHostedZoneId:
    Description: 'The ID of the parent hosted zone.'
    Type: String
  NSRecordValue:
    Description: 'The exported NS record value'
    Type: String
  

Conditions:
  CreateChatBotStackCondition: !Equals
      - !Ref 'CreateChatBotStackCondition'
      - 'true'
  CreateNATGatewayStackCondition: !Equals
      - !Ref 'CreateNATGatewayStackCondition'
      - 'true'
  CreateVPCEndpointStackCondition: !Equals
      - !Ref 'CreateVPCEndpointStackCondition'
      - 'true'
  Route53HostedZoneExist: !Equals
      - !Ref 'Route53HostedZoneExist'
      - 'true'
  Route53HostedZoneNotExist: !Equals
      - !Ref 'Route53HostedZoneExist'
      - 'false'


Resources:
 
  Route53NSRecordStack:
    Condition: Route53HostedZoneNotExist
    Type: AWS::CloudFormation::Stack
    Properties:
      TemplateURL: !Sub 'https://${CFNS3BucketName}.s3.${CFNS3BucketRegion}.amazonaws.com/${StackName}/cfn-templates/p1-route53-NS.yml'
      Parameters:
        StackName: !Ref 'StackName'
        Env: !Ref 'Env'
        ParentHostedZoneName: !Ref 'ParentHostedZoneName'
        ParentHostedZoneId: !Ref 'ParentHostedZoneId'
        
