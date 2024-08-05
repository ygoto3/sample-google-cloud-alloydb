resource "google_project_service" "cloud-resource-manager-api" {
    project = var.project
    service = "cloudresourcemanager.googleapis.com"
    disable_on_destroy = true
}

resource "google_project_service" "compute-engine-api" {
    project = var.project
    service = "compute.googleapis.com"
    disable_on_destroy = true

    depends_on = [google_project_service.cloud-resource-manager-api]
}

resource "google_project_service" "service-networking-api" {
    project = var.project
    service = "servicenetworking.googleapis.com"
    disable_on_destroy = true

    depends_on = [google_project_service.cloud-resource-manager-api]
}

resource "google_project_service" "secret-manager-api" {
    project = var.project
    service = "secretmanager.googleapis.com"
    disable_on_destroy = true

    depends_on = [google_project_service.cloud-resource-manager-api]
}

resource "google_project_service" "alloydb-api" {
    project = var.project
    service = "alloydb.googleapis.com"
    disable_on_destroy = true

    depends_on = [google_project_service.cloud-resource-manager-api]
}
