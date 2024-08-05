resource "google_compute_network" "this" {
    name = var.network_name
    project = var.project
    auto_create_subnetworks = false  
}

resource "google_compute_firewall" "ssh" {
    name = "allow-ssh"
    allow {
        protocol = "tcp"
        ports = ["22"]
    }
    direction = "INGRESS"
    network = google_compute_network.this.id
    priority = 1000
    source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_subnetwork" "this" {
    name = var.subnetwork_name
    ip_cidr_range = "10.0.1.0/24"
    region = var.region
    network = google_compute_network.this.name
}

resource "google_compute_global_address" "private-ip" {
    name = "private-ip"
    address_type = "INTERNAL"
    purpose = "VPC_PEERING"
    prefix_length = 16
    network = google_compute_network.this.id
}

resource "google_service_networking_connection" "vpc_connection" {
    network = google_compute_network.this.name
    service = "servicenetworking.googleapis.com"
    reserved_peering_ranges = [google_compute_global_address.private-ip.name]
}
