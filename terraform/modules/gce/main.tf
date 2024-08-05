resource "google_compute_address" "this" {
    name = "instance-ip"
    region = var.region
    project = var.project
}

resource "google_compute_instance" "this" {
    name = var.instance_name
    machine_type = var.machine_type
    zone = var.zone
    project = var.project
    boot_disk {
        initialize_params {
            image = var.image
            size = 10
            type = "pd-standard"
        }
    }
    network_interface {
        network = var.network
        subnetwork = var.subnetwork
        access_config {
            nat_ip = google_compute_address.this.address
        }
    }
    metadata_startup_script = "sudo apt update; sudo apt install postgresql -y"
}
