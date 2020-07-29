resource "google_compute_instance" "bench" {
    name = "${var.name}-bench"
    machine_type = var.bench_machine_type
    boot_disk {
        initialize_params {
            size  = var.disk_size
            type  = "pd-standard"
            image = var.disk_image
        }
    }
    zone = var.zone
    tags = ["${var.name}-bench"]
    network_interface {
        network = google_compute_network.default.name
        access_config { }
    }
    allow_stopping_for_update = true
    scheduling {
        preemptible = true
        automatic_restart = false
    }
    metadata_startup_script = file("startup-script-bench.sh")
}

resource "google_compute_instance" "web" {
    name = "${var.name}-web"
    machine_type = var.web_machine_type
    boot_disk {
        initialize_params {
            size  = var.disk_size
            type  = "pd-standard"
            image = var.disk_image
        }
    }
    zone = var.zone
    tags = ["${var.name}-web"]
    network_interface {
        network = google_compute_network.default.name
        access_config { }
    }
    allow_stopping_for_update = true
    scheduling {
        preemptible = true
        automatic_restart = false
    }
    metadata_startup_script = templatefile("startup-script-web.sh", { bench-ip = "${google_compute_instance.bench.network_interface.0.access_config.0.nat_ip}" })
}
