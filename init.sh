#!/bin/bash 

mkdir -p issues cfn-flip-output docs/cfn-param-info images/graph images/arch
CFN_TEMPLATES=$(ls -l cfn-templates| awk '{print $9}')

echo "Run cloudformation template Lint test"
cfn-lint -i W2001 -t '**/*.yml' > issues/cfn-lint.issues

echo "Run cloudformation template static analysis test"
python3 scripts/cfn-nag-param-json-convert.py config/cfn.params
cfn_nag_scan -i cfn-templates -o json --parameter-values-path=cfn-nag-params.json >issues/cfn-nag.issues
rm cfn-nag-params.json

for i in $CFN_TEMPLATES ; do
  echo "Performing cloudformation template formatting for file name "$i
  cfn-flip -n -c cfn-templates/$i > cfn-flip-output/$i
done

for i in $CFN_TEMPLATES ; do
  echo "Generating cloudformation parameter info docs for file name "$i
  output=$(echo "$i" | cut -f 1 -d '.')
  python3 scripts/cfn-docs-generator.py $i > docs/cfn-param-info/$output.html
done

echo "Run cloudformation dot graph flow diagram into png format image generator"
for i in $CFN_TEMPLATES ; do
  echo "Generating dot graph flow diagram for file name "$i
  output=$(echo "$i" | cut -f 1 -d '.')
  cfn-lint cfn-templates/$i -g 1> /dev/null
  dot cfn-templates/$i.dot -Tpng -o images/graph/$output.png
  rm cfn-templates/$i.dot
done

echo "Generate AWS Architect Diagram"
cd images/arch && python3 ../../scripts/cfn-arch-design-generator.py
