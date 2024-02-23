import os
import requests
from google.oauth2 import service_account
from google.cloud import storage

credential = service_account.Credentials.from_service_account_file('google_credential.json')

def upload_to_gcs(url, bucket_name):

    filename = url.split('/')[-1]

    response = requests.get(url)

    client = storage.Client(credentials=credential)

    bucket = client.get_bucket(bucket_name)

    blob = bucket.blob(f"trip-data/{filename}")
    blob.upload_from_string(response.content)

def main():

    bucket_name = 'nyc-taxi-zoomcamp-2019-2020'

    url_taxi = 'url_data_taxi.txt'

    with open(url_taxi, 'r') as file:

        urls = file.readlines()

        for url in urls:
            upload_to_gcs(url.strip(), bucket_name)


if __name__ == "__main__":
        
    main()