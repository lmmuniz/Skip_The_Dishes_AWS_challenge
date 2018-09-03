AWS_ACCESS_KEY_ID = 'AKIAIBZ2FSG2U672QY3A'
AWS_SECRET_ACCESS_KEY = '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'
"""
Project: Skip the Dishes - Hackaton VanHack Recruiting Fair 2.0 Sao Paulo 2018
Created on Sun Jun 24 12:01:24 2018
@author: Leonardo Mairene Muniz
Version: v1.0
Description:
    Python Scrypt to move any file from a Transfer folder of Skip the Dishes
    project directory to the Skip the Dishes Amazon S3 bucket (name: skip20180624).
    Once upload is competed, the file is moved to Transferred folder
"""

# Section to import libraries
import boto3
import os
import shutil
#import pandas as pd

#working directories
skip_transfer_folder = 'C:\\PESSOAIS\\Leonardo\\Skip the Dishes\\transfer\\'
skip_transferred_folder = 'C:\\PESSOAIS\\Leonardo\\Skip the Dishes\\transferred\\'


# Amazon S3 connection string, using LEONARDO MAIRENE MUNIZ access key
s3_conn = boto3.resource('s3',
                         aws_access_key_id = AWS_ACCESS_KEY_ID,
                         aws_secret_access_key = AWS_SECRET_ACCESS_KEY
                        )

# function to send files to Amazon S3 bucket
def send_file(bucket,folder,filename):
    # Upload a new file
    try:
        file = folder+filename      
        data = open(file, 'rb')
        s3_conn.Bucket(bucket).put_object(Key=filename, Body=data) 
    finally:
        data.close()
        move_uploaded_file(filename)
    

# function to move uploaded file to Transferred folder
def move_uploaded_file(filename):
    try:    
        shutil.move(skip_transfer_folder + filename, skip_transferred_folder + filename)
        print('\nFile:',filename,'uploaded, moving to Transferred folder...')
    except OSError:
        print('\nSome error on copying or moving the file:',filename)


# function to start the upload process of local files to Amazon S3 bucket
def upload_to_aws_s3():
    

    for filename in os.listdir(skip_transfer_folder):
            print('\nSending file... :',filename)
            send_file(s3_buckets[0],skip_transfer_folder, filename)

#Begin of script to look for files in Transfer folder at project work directory
try:
    s3_buckets = [bucket.name for bucket in s3_conn.buckets.all()]
    print("\nChecking if files exists at Skip Transfer folder")
    if os.listdir(skip_transfer_folder) != []:          
            upload_to_aws_s3()
    else: 
        print("\nNo file exists, stopping...")
except OSError:
        print("\nSome error occurred when iteracting with files")