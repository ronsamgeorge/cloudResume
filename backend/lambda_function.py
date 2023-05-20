import boto3


def lambda_handler(event, context):
    dynamodb = boto3.client('dynamodb')

    response = dynamodb.get_item(
        TableName='cloudresume',
        Key={
            'CounterId': {'N': '1'}
        },
        AttributesToGet=[
            'countValue'
        ]
    )

    updated_count = int(response['Item']['countValue']['N']) + 1

    # update backend DB
    update_response = dynamodb.update_item(
        TableName='cloudresume',
        Key={
            'CounterId': {'N': "1"},
        },
        UpdateExpression='SET countValue = :newCount',
        ExpressionAttributeValues={
            ':newCount': {"N": str(updated_count)}
        },
        ReturnValues="UPDATED_NEW"
    )

    res = {
        'statusCode': 200,
        'body': updated_count,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
    }

    return res
