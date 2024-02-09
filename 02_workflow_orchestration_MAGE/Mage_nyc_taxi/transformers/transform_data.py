import pandas as pd

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):

    df = data.copy()

    #df['lpep_pickup_date'] = pd.to_datetime(df['lpep_pickup_datetime'], format='%y%m%d')
    
    df['lpep_pickup_date'] = df['lpep_pickup_datetime'].dt.date

    column_names = {
                    'VendorID': 'vendor_id',
                    'RatecodeID': 'ratecode_id',
                    'PULocationID': 'PULocation_id',
                    'DOLocationID': 'DOLocation_id',
                    }

    df.rename(columns=column_names, inplace=True)

    df = df[(df['vendor_id'] != 'null')]
    
    df = df[(df['passenger_count'] > 0) | (df['trip_distance'] > 0)]

    print("Rows with zero passengers:", df['passenger_count'].isin([0]).sum())
    print("Rows with zero trip_distance:", df['trip_distance'].isin([0]).sum())

    return df


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
