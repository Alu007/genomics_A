
import os
import io
import boto3
from PIL import Image

s3 = boto3.client('s3')

def handler(event, context):
    for record in event['Records']:
        # Extract bucket and object key from S3 event record
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']

        # Download the image from Bucket A
        response = s3.get_object(Bucket=bucket, Key=key)
        image_data = response['Body'].read()

        # Process the image (remove EXIF metadata)
        image = Image.open(io.BytesIO(image_data))
        image_without_exif = Image.new(image.mode, image.size)
        image_without_exif.putdata(list(image.getdata()))

        # Upload the modified image to Bucket B with the same key
        s3.put_object(Bucket='s3-bucket-b', Key=key, Body=image_without_exif.tobytes())

        return {
         'statusCode': 200,
         'body': 'Object saved to S3 bucket B.'
         'file processed successfully'
    }
