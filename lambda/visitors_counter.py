import json
import boto3
import os

def lambda_handler(event, context):
    # Initialize dynamodb boto3 object
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('visitors_counter')

    # Atomic update item in table or add if doesn't exist
    ddbResponse = table.update_item(
        Key={
            "id": "count"
        },
        UpdateExpression='ADD visitor_count :inc',
        ExpressionAttributeValues={
            ':inc': 1
        },
        ReturnValues="UPDATED_NEW"
    )

    # Format dynamodb response into variable
    responseBody = json.dumps({"count": int(float(ddbResponse["Attributes"]["visitor_count"]))})

    # Create api response object
    apiResponse = {
        "isBase64Encoded": False,
        "statusCode": 200,
        "body": responseBody,
        "headers": {
            "Access-Control-Allow-Headers" : "Content-Type,X-Amz-Date,Authorization,X-Api-Key,x-requested-with",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "GET,OPTIONS" 
        },
    }

    # Return api response object
    return apiResponse