
#!/usr/bin/env python
import json
import sys
import yaml
import os

# Extract input file as variable
try:
    filename = sys.argv[1]
except IndexError as e:
    print("No file to convert, please file content format must be key=value pair")


#List variable for output json format
json_dict = {} 



# Open input file for conversion
with open(filename) as cfn_input_file:  

    # Perform for loop to extract all lines
    for line in cfn_input_file:
        
        if not line.isspace():
            # reading line by line from the text file by splitting "="
            content = list((line.strip().split("=")))

            # Insert json key value pair
            json_dict[content[0].strip()]=content[1].strip()

       
# with open('serverless-secret-arn-export.yml', 'r') as stream:
#   obj = yaml.load(stream,Loader=yaml.BaseLoader)
# x="1"
# y="2"
with open('serverless.yml', 'r') as stream:
    obj = yaml.load(stream,Loader=yaml.FullLoader)
    print(obj)
    for x,y in json_dict.items():
        obj["resources"]["Outputs"][x] = {
        "Description": "Exporting Secret name "+x,
        "Value": y,
        "Export":{
            "Name": x
            } 
        }
        with open("serverless.yml", "w") as wStream:
            yaml.dump(obj, wStream, indent=2, sort_keys=False)
