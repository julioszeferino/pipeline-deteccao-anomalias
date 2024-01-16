terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("dsa-key.json")
  project     = "projeto-dsa-big-query"
  region      = "us-central1"
  zone        = "us-central1-c"
}

# resource "google_compute_network" "vpc_network_dsa_bigquery" {
#   name = "vpc-network-dsa-bigquery"
# }



# configurando o acesso publico ao big query
# resource "google_bigquery_dataset_access" "bqdsajulio" {
#   dataset_id = google_bigquery_dataset.warehouse.dataset_id
#   role       = "READER"
#   user_by_email = google_service_account.bqdsajulio.email
# }

# criando a tabela no big query
# resource "google_bigquery_table" "bqdsajulio" {
#   dataset_id = google_bigquery_dataset.warehouse.dataset_id
#   table_id   = "bqdsajulio"
#   time_partitioning {
#     type = "DAY"
#   }
#   labels = {
#     env = "default"
#   }
#   schema {
#     fields {
#       name = "name"
#       type = "STRING"
#     }
#     fields {
#       name = "age"
#       type = "INTEGER"
#     }
#     fields {
#       name = "birthday"
#       type = "DATE"
#     }
#   }
# }
