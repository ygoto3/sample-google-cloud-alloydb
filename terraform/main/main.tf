module "alloydb" {
    source = "../modules/alloydb"

    project = var.project
    cluster_name = "sample-alloydb"
    region_primary = var.region
    region_secondary = var.region_secondary
    network = google_compute_network.this.id
}

module "gce" {
    source = "../modules/gce"

    project = var.project
    region = var.region
    zone = var.zone
    instance_name = var.instance_name
    machine_type = var.machine_type
    image = var.image

    network = google_compute_network.this.self_link
    subnetwork = google_compute_subnetwork.this.self_link
}
