#!/bin/bash 
aws s3 sync cfn-templates/ s3://devops-cfn-templates1/stage/cfn-templates --delete