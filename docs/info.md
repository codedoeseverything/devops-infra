1. To find Redis latest engine version details-

aws elasticache describe-cache-engine-versions --engine redis --query "CacheEngineVersions[].EngineVersion"

2. To find canonical id of AWs accouunt used for S3 ACL

aws s3api list-buckets --query Owner.ID --output text --profile p2

3. To configure cfn-lint as precommit 
https://aws.amazon.com/blogs/mt/git-pre-commit-validation-of-aws-cloudformation-templates-with-cfn-lint/