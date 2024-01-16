# criando dataset no big query
resource "google_bigquery_dataset" "warehouse" {
  dataset_id            = "warehouse"      # nome do dataset
  friendly_name         = "warehouse"      # nome amigavel do dataset
  description           = "Data Warehouse" # descricao do dataset
  location              = "US"             # localizacao do dataset
  max_time_travel_hours = 168              # tempo maximo para recuperar dados excluidos (em horas)


  labels = {
    environment = "production"
    owner       = "terraform"
  }

  access {
    role   = "READER"
    domain = "hashicorp.com"
  }

}

# criando a conta de servico
resource "google_bigquery_dataset_access" "access" {
  dataset_id    = google_bigquery_dataset.warehouse.dataset_id
  role          = "WRITER"
  user_by_email = google_service_account.dsajulioszeferino.email
  depends_on    = [google_bigquery_dataset.warehouse, google_service_account.dsajulioszeferino]
}

# permitir que a conta de servico acesso o projeto-dsa-big-query como editor
resource "google_project_iam_member" "accessacount" {
  project = "projeto-dsa-big-query"
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.dsajulioszeferino.email}"
  depends_on = [google_service_account.dsajulioszeferino]
}


resource "google_service_account" "dsajulioszeferino" {
  account_id  = "dsajulioszeferino"
  description = "Conta de serviço para acesso ao Big Query"
}


############### DIM_CLIENTE ################
resource "google_bigquery_table" "dim_cliente" {
  dataset_id          = google_bigquery_dataset.warehouse.dataset_id
  table_id            = "dim_cliente"
  deletion_protection = false

  external_data_configuration {

    source_format = "CSV"
    source_uris   = ["gs://${google_storage_bucket.dados.name}/${google_storage_bucket_object.dim-cliente.name}"]
    autodetect    = true
    csv_options {
      quote             = "\""
      skip_leading_rows = 1
      field_delimiter   = ","
    }
  }

  depends_on = [google_bigquery_dataset.warehouse]
}

############### DIM_LOCALIDADE ################
resource "google_bigquery_table" "dim_localidade" {
  dataset_id          = google_bigquery_dataset.warehouse.dataset_id
  table_id            = "dim_localidade"
  deletion_protection = false

  external_data_configuration {

    source_format = "CSV"
    source_uris   = ["gs://${google_storage_bucket.dados.name}/${google_storage_bucket_object.dim-localidade.name}"]
    autodetect    = true
    csv_options {
      quote             = "\""
      skip_leading_rows = 1
      field_delimiter   = ","
    }
  }

  depends_on = [google_bigquery_dataset.warehouse]
}

############### DIM_PRODUTO ################
resource "google_bigquery_table" "dim_produto" {
  dataset_id          = google_bigquery_dataset.warehouse.dataset_id
  table_id            = "dim_produto"
  deletion_protection = false

  external_data_configuration {

    source_format = "CSV"
    source_uris   = ["gs://${google_storage_bucket.dados.name}/${google_storage_bucket_object.dim-produto.name}"]
    autodetect    = true
    csv_options {
      quote             = "\""
      skip_leading_rows = 1
      field_delimiter   = ","
    }
  }

  depends_on = [google_bigquery_dataset.warehouse]
}

############### DIM_TEMPO ################
resource "google_bigquery_table" "dim_tempo" {
  dataset_id          = google_bigquery_dataset.warehouse.dataset_id
  table_id            = "dim_tempo"
  deletion_protection = false

  external_data_configuration {

    source_format = "CSV"
    source_uris   = ["gs://${google_storage_bucket.dados.name}/${google_storage_bucket_object.dim-tempo.name}"]
    autodetect    = true
    csv_options {
      quote             = "\""
      skip_leading_rows = 1
      field_delimiter   = ","
    }
  }

  depends_on = [google_bigquery_dataset.warehouse]
}

############### FATO_VENDA ################
resource "google_bigquery_table" "fato_venda" {
  dataset_id          = google_bigquery_dataset.warehouse.dataset_id
  table_id            = "fato_venda"
  deletion_protection = false

  external_data_configuration {

    source_format = "CSV"
    source_uris   = ["gs://${google_storage_bucket.dados.name}/${google_storage_bucket_object.fato-venda.name}"]
    autodetect    = true
    csv_options {
      quote             = "\""
      skip_leading_rows = 1
      field_delimiter   = ","
    }
  }

  depends_on = [google_bigquery_dataset.warehouse]
}



