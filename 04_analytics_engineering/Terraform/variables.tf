variable "credentials" {
  type    = string
  default = "google_credentials.json"
}

variable "project" {
  type    = string
  default = "dbt-zoomcamp-2024"
}

variable "region" {
  type    = string
  default = "asia-southeast2-b"
}

variable "gcs_bucket_name" {
  type    = string
  default = "nyc-taxi-zoomcamp-2019-2020"
}

variable "location" {
  type    = string
  default = "asia-southeast2"
}

variable "dataset_name" {
  type    = string
  default = "nyc_taxi_zoomcamp"
}