provider "google" {
  region = "us-central1"
  zone = "us-central1-c"
  project = "evident-zone-280704"
  credentials = "evident-zone-280704-99b1d8e3f6d6.json"
}
resource "google_storage_bucket_object" "archive" {
  name = "index.zip"
  bucket = "gcf-sources-394511129075-us-central1"
  source = "/home/nareshyanduri1919/function-source.zip"
}
resource "google_cloudfunctions_function" "function" {
  name = var.name.name
  description = "my test function"
  runtime = var.name.python
  available_memory_mb = 128
  source_archive_bucket = "gcf-sources-394511129075-us-central1"
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http = true
  timeout = 60
  entry_point = "hello_world"
}
