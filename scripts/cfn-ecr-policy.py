# Python program to update
# JSON


import json

# function to add to JSON
def write_json(data, filename='current-iam-policy.json'):
	with open(filename,'w') as f:
		json.dump(data, f, indent=4)
	
	
with open('current-iam-policy.json') as json_file:
	data = json.load(json_file)
	temp = data['Statement']

	#python object to be appended
	y = {
        "Sid": "NAME",
        "Effect": "Allow",
        "Principal": {
            "AWS": "arn:aws:iam::CURRENT:root"
        },
        "Action": [
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchCheckLayerAvailability",
            "ecr:PutImage",
            "ecr:InitiateLayerUpload",
            "ecr:UploadLayerPart",
            "ecr:CompleteLayerUpload"
        ]
    }

	# appending data to emp_details
	temp.append(y)
	
write_json(data)
