resource "google_storage_bucket" "dados" {
  name          = "dados-dsa-big-query"
  location      = "US"
  storage_class = "STANDARD"

  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "dim-cliente" {
  name         = "DIMENSAO_CLIENTE.csv"
  source       = "../data/DIMENSAO_CLIENTE.csv"
  content_type = "text/plain"
  bucket       = google_storage_bucket.dados.id
}


resource "google_storage_bucket_object" "dim-localidade" {
  name         = "DIMENSAO_LOCALIDADE.csv"
  source       = "../data/DIMENSAO_LOCALIDADE.csv"
  content_type = "text/plain"
  bucket       = google_storage_bucket.dados.id
}


resource "google_storage_bucket_object" "dim-produto" {
  name         = "DIMENSAO_PRODUTO.csv"
  source       = "../data/DIMENSAO_PRODUTO.csv"
  content_type = "text/plain"
  bucket       = google_storage_bucket.dados.id
}


resource "google_storage_bucket_object" "dim-tempo" {
  name         = "DIMENSAO_TEMPO.csv"
  source       = "../data/DIMENSAO_TEMPO.csv"
  content_type = "text/plain"
  bucket       = google_storage_bucket.dados.id
}

resource "google_storage_bucket_object" "fato-venda" {
  name         = "FATO_VENDA.csv"
  source       = "../data/FATO_VENDA.csv"
  content_type = "text/plain"
  bucket       = google_storage_bucket.dados.id
}