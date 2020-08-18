resource "google_compute_subnetwork" "bench" {
    name          = "${var.name}-subnet-bench"
    ip_cidr_range = "10.0.1.0/24"
    region        = var.bench-region
    network       = google_compute_network.default.id
}

resource "google_compute_subnetwork" "web" {
    name          = "${var.name}-subnet-web"
    ip_cidr_range = "10.0.2.0/24"
    region        = var.web-region
    network       = google_compute_network.default.id
}
