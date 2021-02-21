#!/bin/bash 

mkdir -p issues

echo "Run cloudformation template Lint test"
cfn-lint -t '**/*.yml' >> issues/cfn-lint.issues

echo "Run cloudformation template static analysis test"
cfn_nag_scan -i cfn-templates -o json >>issues/cfn_nag_issues

mkdir -p cfn-flip-output
cd cfn-templates

FILES=$(ls *.yml)
for i in $FILES ; do
  echo "Performing cloudformation formatting for file name "$i
  cfn-flip -n -c $i >> ../cfn-fix-format/$i
done