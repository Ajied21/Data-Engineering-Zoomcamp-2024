variable "credentials" {
  type    = string
  default = "google_credentials.json"
}

variable "project" {
  type    = string
  default = "spark-project-416002"
}

variable "region" {
  type    = string
  default = "asia-southeast2-b"
}

variable "gcs_bucket_name" {
  type    = string
  default = "fhv-zoomcamp-2019-2020"
}

variable "location" {
  type    = string
  default = "asia-southeast2"
}

variable "dataset_name" {
  type    = string
  default = "fhv_zoomcamp"
}