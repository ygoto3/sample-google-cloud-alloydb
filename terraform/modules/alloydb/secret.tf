resource "google_secret_manager_secret" "alloydb" {
    secret_id = "alloydb-secret"

    labels = {
      "env" = "dev"
    }

    replication {
      auto {}
    }
}

resource "google_secret_manager_secret_version" "alloydb" {
    secret = google_secret_manager_secret.alloydb.id
    secret_data = random_password.alloydb-admin.result
}
