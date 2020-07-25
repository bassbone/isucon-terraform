provider "google" {}

resource "google_compute_network" "default" {
    name = var.name
}

resource "google_compute_firewall" "ssh" {
    name = "${var.name}-ssh"
    network = google_compute_network.default.name
    allow {
        protocol = "tcp"
        ports = ["22"]
    }

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["${var.name}-bench", "${var.name}-web"]
}

resource "google_compute_firewall" "https" {
    name = "${var.name}-https"
    network = google_compute_network.default.name
    allow {
        protocol = "tcp"
        ports = ["443"]
    }

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["${var.name}-web"]
}

resource "google_compute_firewall" "shipment" {
    name = "${var.name}-shipment"
    network = google_compute_network.default.name
    allow {
        protocol = "tcp"
        ports = ["7000"]
    }

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["${var.name}-bench"]
}

resource "google_compute_firewall" "payment" {
    name = "${var.name}-payment"
    network = google_compute_network.default.name
    allow {
        protocol = "tcp"
        ports = ["5555"]
    }

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["${var.name}-bench"]
}

resource "google_compute_instance" "bench" {
    name = "${var.name}-bench"
    machine_type = var.bench_machine_type
    boot_disk {
        initialize_params {
            size  = 20
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
    metadata_startup_script = templatefile("startup-script-bench.sh", { web-ip = "${google_compute_instance.web.network_interface.0.access_config.0.nat_ip}" })
}

resource "google_compute_instance" "web" {
    name = "${var.name}-web"
    machine_type = var.web_machine_type
    boot_disk {
        initialize_params {
            size  = 20
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
    metadata_startup_script = file("startup-script-web.sh")
}
