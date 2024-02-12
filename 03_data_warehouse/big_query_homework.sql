-- Creating external table referring to gcs path

CREATE OR REPLACE EXTERNAL TABLE terraform-zoomcamp-2024.green_taxi_tripdata.green_tripsdata_2022
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://green-taxi-tripdata-2022-zoompcamp/green_tripdata_2022-*.parquet'] 
);


-- QUESTION 1 at homework week3

SELECT count(*) FROM 'terraform-zoomcamp-2024.green_taxi_tripdata.green_tripsdata_2022';

-- ANSWER: 840,402


-- QUESTION 2 at homework week3

SELECT COUNT(DISTINCT(PULocationID)) FROM 'terraform-zoomcamp-2024.green_taxi_tripdata.green_tripsdata_2022';

-- ANSWER: 0 MB for the External Table and 6.41MB for the Materialized Table.


-- QUESTION 3 at homework week3

SELECT SUM(IF(fare_amount=0, 1, 0)) FROM 'terraform-zoomcamp-2024.green_taxi_tripdata.green_tripsdata_2022';

-- ANSWER: 1622


-- QUESTION 4 at homework week3

CREATE OR REPLACE TABLE terraform-zoomcamp-2024.green_taxi_tripdata.green_tripsdata_2022_by_lpep_pickup
PARTITION BY DATE('lpep_pickup_datetime')
CLUSTER BY PUlocationID AS (
  SELECT * FROM `terraform-zoomcamp-2024.green_taxi_tripdata.green_tripsdata_2022`
);

-- ANSWER: Partition by lpep_pickup_datetime and cluster by PUlocationID


-- QUESTION 5 at homework week3

SELECT DISTINCT PULocationID FROM  'terraform-zoomcamp-2024.green_taxi_tripdata.green_tripsdata_2022_by_lpep_pickup'
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30'

-- ANSWER: This query will process 12.82 MB when run. 

SELECT DISTINCT PULocationID FROM  'terraform-zoomcamp-2024.green_taxi_tripdata.green_tripsdata_2022_by_lpep_pickup'
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30'

-- ANSWER: This query will process 1.12 MB when run.


-- QUESTION 6 at homework week3

-- ANSWER: GCP Bucket


-- QUESTION 7 at homework week3

-- ANSWER: True