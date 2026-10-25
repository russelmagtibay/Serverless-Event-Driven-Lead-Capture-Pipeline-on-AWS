import json
import boto3
import os
from datetime import datetime

# Initialize AWS SDK clients outside the handler (Enterprise best practice for connection reuse)
dynamodb = boto3.resource("dynamodb")
ses = boto3.client("ses")

def handler(event, context):
    headers = {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "Content-Type",
        "Access-Control-Allow-Methods": "POST,OPTIONS",
        "Content-Type": "application/json"
    }

    # Handle CORS preflight browser check
    if event.get("requestContext", {}).get("http", {}).get("method") == "OPTIONS":
        return {"statusCode": 200, "headers": headers, "body": ""}

    try:
        # Parse incoming JSON body from frontend
        body = json.loads(event.get("body", "{}"))
        email = body.get("email")
        name = body.get("name", "Valued Customer")
        message = body.get("message", "No message provided.")

        if not email:
            return {
                "statusCode": 400,
                "headers": headers,
                "body": json.dumps({"error": "Email is required."})
            }

        timestamp = datetime.utcnow().isoformat()

        # 1. Store Lead in DynamoDB
        table_name = os.environ.get("DYNAMODB_TABLE")
        table = dynamodb.Table(table_name)
        table.put_item(
            Item={
                "email": email,
                "timestamp": timestamp,
                "name": name,
                "message": message
            }
        )

        # 2. Send Email Alert via Amazon SES
        sender_email = os.environ.get("NOTIFICATION_EMAIL")
        ses.send_email(
            Source=sender_email,
            Destination={"ToAddresses": [sender_email]},
            Message={
                "Subject": {"Data": f"🎉 New Lead Captured: {name}"},
                "Body": {
                    "Text": {
                        "Data": f"New Lead Details:\n\nName: {name}\nEmail: {email}\nMessage: {message}\nSubmitted: {timestamp}"
                    }
                }
            }
        )

        return {
            "statusCode": 200,
            "headers": headers,
            "body": json.dumps({"message": "Thank you! Your lead has been captured successfully."})
        }

    except Exception as e:
        print(f"Error processing lead: {str(e)}")
        return {
            "statusCode": 500,
            "headers": headers,
            "body": json.dumps({"error": "Internal server error."})
        }