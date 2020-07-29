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

