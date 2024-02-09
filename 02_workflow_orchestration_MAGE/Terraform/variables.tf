variable "credentials" {
  type    = string
  default = "Mage_keys_GCP.json"
}

variable "project" {
  type    = string
  default = "terraform-zoomcamp-2024"
}

variable "region" {
  type    = string
  default = "asia-southeast2-b"
}

variable "gcs_bucket_name" {
  type    = string
  default = "mage_de_zoomcamp_2024"
}

variable "location" {
  type    = string
  default = "asia-southeast2"
}

variable "dataset_name" {
  type    = string
  default = "nyc_taxi_zoomcamp_2024"
}