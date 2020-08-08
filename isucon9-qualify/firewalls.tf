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

resource "google_compute_firewall" "external" {
    name = "${var.name}-external"
    network = google_compute_network.default.name
    allow {
        protocol = "tcp"
        ports = ["5555", "7000"]
    }
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["${var.name}-bench"]
}

resource "google_compute_firewall" "internal" {
    name = "${var.name}-internal"
    network = google_compute_network.default.name
    allow {
        protocol = "tcp"
        ports = ["0-65535"]
    }
    source_ranges = ["10.0.0.0/16"]
    target_tags = ["${var.name}-web"]
}

resource "google_compute_firewall" "netdata" {
    name = "${var.name}-netdata"
    network = google_compute_network.default.name
    allow {
        protocol = "tcp"
        ports = ["19999"]
    }
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["${var.name}-web"]
}

