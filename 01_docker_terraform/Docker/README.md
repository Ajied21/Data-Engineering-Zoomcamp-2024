# build container in dockerfile

docker build -t nyc_taxi_trips:0.1 .

# run docker for ingestion data type parquet

docker run \
    --network=DE_zoomcamp_2024 \
    nyc_taxi_trips:0.1 \
    --user=ajied_dhoifullah \
    --password=admin \
    --database=nyc_taxi \
    --host=postgres-database \
    --file=green_tripdata_2021-01.parquet \
    --table_name=trips_green_taxi \
    --url=https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2019-09.parquet 

# run docker for ingestion data type csv

docker run \
    --network=DE_zoomcamp_2024 \
    nyc_taxi_trips:0.1 \
    --user=ajied_dhoifullah \
    --password=admin \
    --database=nyc_taxi \
    --host=postgres-database \
    --file=taxi+_zone_lookup.csv \
    --table_name=taxi_zone_lookup \
    --url=https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv


===================================================================================================================================================

# build image docker for database postgressql in localhost

docker run -it \
  -e POSTGRES_USER="ajied_dhoifullah" \
  -e POSTGRES_PASSWORD="admin" \
  -e POSTGRES_DB="ny_taxi" \
  -v ./ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5435:5432 \
  --network=pg-networks \
  --name postgres-database \
  postgres:15

# build image docker for pgadmin4 in ui browser

docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="ajied@zoomcamp.com" \
  -e PGADMIN_DEFAULT_PASSWORD="admin" \
  -p 8080:80 \
  --network=pg-networks \
  --name pgadmin \
  dpage/pgadmin4:latest

# don't forget create docker network
docker network create pg-networks

# check postgresql in pgcli on bash shell or cmd, I used port: 5435
pgcli -h localhost -p 5435 -u root -d nyc_taxi
