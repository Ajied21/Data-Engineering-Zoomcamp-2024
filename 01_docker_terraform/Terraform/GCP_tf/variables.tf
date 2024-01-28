variable "credentials" {
  type    = string
  default = "my-keys.json"
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
  default = "de_zoomcamp_ajid_2024"
}

variable "location" {
  type    = string
  default = "asia-southeast2"
}

variable "dataset_name" {
  type    = string
  default = "de_zoomcamp_data_2024"
}