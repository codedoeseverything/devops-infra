#!/bin/bash 

mkdir -p issues

echo "Run cloudformation template Lint test"
cfn-lint -t '**/*.yml' >> issues/cfn-lint.issues

echo "Run cloudformation template static analysis test"
cfn_nag_scan -i cfn-templates -o json >>issues/cfn_nag_issues

mkdir -p cfn-flip-output
cd cfn-templates

CFN_TEMPLATES=$(ls *.yml)
for i in $CFN_TEMPLATES ; do
  echo "Performing cloudformation formatting for file name "$i
  cfn-flip -n -c $i >> ../cfn-flip-output/$i
done


mkdir -p docs
echo "Run cloudformation docs generator"
CFN_TEMPLATES=$(ls *.yml)
for i in $CFN_TEMPLATES ; do
  echo "Generating cloudformation docs for file name "$i
  python3 ../scripts/cfn-docs-generator.py $i >> ../docs/$i.html
done