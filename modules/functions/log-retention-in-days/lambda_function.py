import boto3
import os

Days=os.environ['RETENTION_IN_DAYS']

def handler(event, context):
    logs_client = boto3.client('logs')
    response = logs_client.describe_log_groups()

    group_list = response['logGroups']

    while 'nextToken' in response:
        response = logs_client.describe_log_groups(nextToken=response['nextToken'])
        add_groups = response['logGroups']
        group_list.extend(add_groups)

    for log_group in group_list:
        print(log_group['logGroupName'])
        result = logs_client.put_retention_policy(
            logGroupName=log_group['logGroupName'],
            retentionInDays=int(Days)
        )
        code = result['ResponseMetadata']['HTTPStatusCode']
        print('HTTPStatusCode is ' + str(code))