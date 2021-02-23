#!/bin/bash 

mkdir -p docs
echo "Run cloudformation docs generator"
cd cfn-templates
CFN_TEMPLATES=$(ls *.yml)
for i in $CFN_TEMPLATES ; do
  echo "Generating cloudformation docs for file name "$i
  python3 scripts/cfn-docs-generator.py $i >> docs/$i.html
done