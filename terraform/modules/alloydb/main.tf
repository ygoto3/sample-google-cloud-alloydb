resource "google_alloydb_cluster" "primary" {
    cluster_id = "${var.cluster_name}-primary"
    location = var.region_primary

    network_config {
        network = var.network
    }

    initial_user {
        user = "admin"
        password = random_password.alloydb-admin.result
    }

    automated_backup_policy {
        enabled = true
        backup_window = "3600s"
        location = var.region_primary

        weekly_schedule {
            days_of_week = ["MONDAY"]
            start_times {
                hours = 23
                minutes = 0
                seconds = 0
                nanos = 0
            }
        }

        quantity_based_retention {
            count = 1
        }
    }

    continuous_backup_config {
        enabled = true
        recovery_window_days = 14
    }

    labels = {
        "env" = "dev"
    }
}

resource "google_alloydb_instance" "primary" {
    cluster = google_alloydb_cluster.primary.name
    instance_id = "${var.cluster_name}-primary"
    instance_type = "PRIMARY"
    display_name = "${var.cluster_name}-primary"

    machine_config {
        cpu_count = 2
    }

    labels = {
        "env" = "dev"
    }
}

resource "google_alloydb_instance" "read-pool" {
    cluster = google_alloydb_cluster.primary.name
    instance_id = "${var.cluster_name}-read-pool"
    instance_type = "READ_POOL"
    display_name = "${var.cluster_name}-read-pool"

    read_pool_config {
        node_count = 1
    }

    machine_config {
        cpu_count = 2
    }

    labels = {
        "env" = "dev"
    }

    depends_on = [google_alloydb_instance.primary]
}

resource "random_password" "alloydb-admin" {
    length = 16
    special = false  
}
