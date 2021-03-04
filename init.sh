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


mkdir -p ../docs/cfn-param-info
echo "Run cloudformation docs generator"
CFN_TEMPLATES=$(ls *.yml)
for i in $CFN_TEMPLATES ; do
  echo "Generating cloudformation docs for file name "$i
  output=$(echo "$i" | cut -f 1 -d '.')
  python3 ../scripts/cfn-docs-generator.py $i >> ../docs/cfn-param-info/$output.html
done


mkdir -p ../images/graph
cp *.yml ../images/graph
cd ../images/graph
echo "Run cloudformation dot graph flow diagram into png format image generator"
CFN_TEMPLATES=$(ls *.yml)
for i in $CFN_TEMPLATES ; do
  echo "Generating dot graph flow diagram for file name "$i
  output=$(echo "$i" | cut -f 1 -d '.')
  cfn-lint $i -g
  dot $i.dot -Tpng -o $output.png
  rm $i $i.dot
done
