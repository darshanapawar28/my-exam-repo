import json
import requests

def lambda_handler(event, context):
    payload = {
        "subnet_id": event["subnet_id"],
        "name": "Darshana Pawar",
        "email": "darshanapawar74@gmail.com"
    }
    headers = {'X-Siemens-Auth': 'test'}
    response = requests.post(
        "https://bc1yy8dzsg.execute-api.eu-west-1.amazonaws.com/v1/data",
        headers=headers, json=payload
    )
    return response.json()
