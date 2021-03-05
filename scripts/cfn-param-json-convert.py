#!/usr/bin/env python
import json
import sys


# Extract input file as variable
try:
    filename = sys.argv[1]
except IndexError as e:
    print("No file to convert, please file content format must be key=value pair")


#List variable for output json format
json_list= []

#Dictonary variable for key value formatting
json_dict = {} 

#Mandatory fields for cfn json parameters
if 'params' in filename:
    cfn_json_key =['ParameterKey', 'ParameterValue']
    cfn_outfile_file = 'config/cfn-params.json'
elif 'tags' in filename:
    cfn_json_key =['Key', 'Value']
    cfn_outfile_file = 'config/cfn-tags.json'
else:
    print("Not Valid file")


# Open input file for conversion
with open(filename) as cfn_input_file:  

    # Perform for loop to extract all lines
    for line in cfn_input_file:
        
        if not line.isspace():
            # reading line by line from the text file by splitting "="
            content = list((line.strip().split("=")))

            # Insert json key value pair
            json_dict = {cfn_json_key[0]:content[0].strip(),cfn_json_key[1]:content[1].strip()}

            # Append to list
            json_list.append(json_dict)
                    
# creating output json file         
out_file = open(cfn_outfile_file, "w") 
json.dump(json_list, out_file, indent = 4) 
out_file.close() 




       