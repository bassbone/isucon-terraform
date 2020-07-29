output "zone" {
    value = google_compute_instance.default.*.zone
}

output "network_interface" {
    value = google_compute_instance.default.*.network_interface
}

output "name" {
    value = google_compute_instance.default.*.name
}

