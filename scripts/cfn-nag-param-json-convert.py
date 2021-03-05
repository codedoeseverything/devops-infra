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

cfn_outfile_file = '../cfn-nag-params.json'

#List variable for output json format
json_dict = {} 
json_final= {"Parameters":json_dict}

#Dictonary variable for key value formatting




cfn_outfile_file = 'cfn-nag-params.json'

# Open input file for conversion
with open(filename) as cfn_input_file:  

    # Perform for loop to extract all lines
    for line in cfn_input_file:
        
        if not line.isspace():
            # reading line by line from the text file by splitting "="
            content = list((line.strip().split("=")))

            # Insert json key value pair
            json_dict[content[0].strip()]=content[1].strip()
                    
# creating output json file         
out_file = open(cfn_outfile_file, "w") 
json.dump(json_final, out_file, indent = 4) 
out_file.close() 


       