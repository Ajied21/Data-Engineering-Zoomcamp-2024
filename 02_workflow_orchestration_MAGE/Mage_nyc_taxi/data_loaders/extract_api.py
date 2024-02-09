import io
import pandas as pd
import requests
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """
    url_2020_10 = 'https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2020-10.csv.gz'
    
    url_2020_11 = 'https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2020-11.csv.gz'
    
    url_2020_12 = 'https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2020-12.csv.gz'

    column_type_data = {
        'VendorID': pd.Int64Dtype(),
        'store_and_fwd_flag': str,
        'RatecodeID': pd.Int64Dtype(),
        'PULocationID': pd.Int64Dtype(),
        'DOLocationID': pd.Int64Dtype(),
        'passenger_count': pd.Int64Dtype(),
        'trip_distance': float,
        'fare_amount': float,
        'extra': float,
        'mta_tax': float,
        'tip_amount': float,
        'tolls_amount': float,
        'ehail_fee': str,
        'improvement_surcharge': float,
        'total_amount': float,
        'payment_type': pd.Int64Dtype(),
        'trip_type': pd.Int64Dtype(),
        'congestion_surcharge': float
    }

    date_data = ['lpep_pickup_datetime', 'lpep_dropoff_datetime']

    taxi_2020_10 = pd.read_csv(url_2020_10, sep=",", compression="gzip", dtype=column_type_data, parse_dates=date_data)
    
    taxi_2020_11 = pd.read_csv(url_2020_11, sep=",", compression="gzip", dtype=column_type_data, parse_dates=date_data)
    
    taxi_2020_12 = pd.read_csv(url_2020_12, sep=",", compression="gzip", dtype=column_type_data, parse_dates=date_data)

    dataframe = pd.concat([taxi_2020_10, taxi_2020_11, taxi_2020_12], ignore_index=False)
    
    
    return dataframe


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
