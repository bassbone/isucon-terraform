resource "google_compute_instance" "default" {
    name = var.name
    machine_type = var.machine_type
    boot_disk {
        initialize_params {
            size  = var.disk_size
            type  = "pd-standard"
            image = var.disk_image
        }
    }
    zone = var.zone
    tags = [var.tags]
    network_interface {
        network = var.network_name
        access_config { }
    }
    allow_stopping_for_update = true
    scheduling {
        preemptible = true
        automatic_restart = false
    }
    metadata_startup_script = var.metadata_startup_script
}

