# COMMAND FOR DOWNLOADING INTO LOCAL
wget -i url_data_taxi.txt -P data/ -w 2


# COMMAND FOR DOWNLOADING AND MOVE INTO GCS FOLDER
#!/bin/bash

# Read each URL from url_data_taxi.txt
while IFS= read -r url; do
    # Extract the filename from the URL
    filename=$(basename "$url")
    
    # Use wget to download the file
    wget "$url" -O "$filename"
    
    # Use gsutil to copy the downloaded file to Google Cloud Storage
    gsutil cp "$filename" gs://nyc-taxi-zoomcamp-2019-2020/trip-data/
    
    # Remove the downloaded file after uploading
    rm "$filename"
done < url_data_taxi.txt