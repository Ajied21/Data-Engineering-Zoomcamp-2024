from google.oauth2 import service_account
from google.cloud import storage
from google.cloud import bigquery
import polars as pl
import requests
import io
import os
from io import BytesIO

credential = service_account.Credentials.from_service_account_file('my-keys.json')


url_green_taxi_nyc = [
    "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-01.parquet",
    "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-02.parquet",
    "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-03.parquet",
    "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-04.parquet",
    "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-05.parquet",
    "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-06.parquet",
    "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-07.parquet",
    "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-08.parquet",
    "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-09.parquet",
    "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-10.parquet",
    "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-11.parquet",
    "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-12.parquet"
]

for i, url in enumerate(url_green_taxi_nyc, start=1):
    df = pl.read_parquet(url)
    filename = f"green_tripdata_2022-{i}.parquet"
    df.write_parquet(filename)

def upload_to_gcs(files, bucket_name:str):
    client_s = storage.Client(credentials=credential)
    bucket = client_s.bucket(bucket_name)

    for file in files:
        blob = bucket.blob(file)
        blob.upload_from_filename(file)

def load_to_bigquery(bucket_name:str, dataset_id:str):
    
    client_b = bigquery.Client(credentials=credential)
    dataset_ref = client_b.dataset(dataset_id)

    job_config = bigquery.LoadJobConfig(
        source_format=bigquery.SourceFormat.PARQUET,
        autodetect=True
    )

    storage_client = storage.Client(credentials=credential)
    bucket = storage_client.bucket(bucket_name)
    blobs = bucket.list_blobs()

    for blob in blobs:
        if blob.name.endswith('.parquet'):
            filename = os.path.basename(blob.name).replace('.parquet', '')
            table_id = filename.replace('-', '_')
            table_ref = dataset_ref.table(table_id)

            uri = f"gs://{bucket_name}/{blob.name}"

            load_job = client_b.load_table_from_uri(
                uri,
                table_ref,
                job_config=job_config
            )

            load_job.result()
            

if __name__=="__main__":

    try:

        name_file = [f"green_tripdata_2022-{i}.parquet" for i in range(1, 13)]
        
        upload_to_gcs(name_file, 'green-taxi-tripdata-2022-zoompcamp')

        load_to_bigquery('green-taxi-tripdata-2022-zoompcamp', 'green_taxi_tripdata')

        print(f'data success to upload gcs and bigquery')

    except:

        print(f'unsuccess data to upload gcs and bigquery')