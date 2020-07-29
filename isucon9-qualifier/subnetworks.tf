resource "google_compute_subnetwork" "default" {
    name          = "${var.name}-subnet"
    ip_cidr_range = "10.0.0.0/16"
    region        = var.region
    network       = google_compute_network.default.id
}
