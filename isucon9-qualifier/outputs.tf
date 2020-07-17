output "bench_address" {
    value = "${google_compute_instance.bench.network_interface.0.access_config.0.nat_ip}"
}

output "web_address" {
    value = "${google_compute_instance.web.network_interface.0.access_config.0.nat_ip}"
}

output "bench_ssh" {
    value = "gcloud compute ssh \"${google_compute_instance.bench.name}\" --zone \"${google_compute_instance.bench.zone}\""
}

output "web_ssh" {
    value = "gcloud compute ssh \"${google_compute_instance.web.name}\" --zone \"${google_compute_instance.web.zone}\""
}

output "bench_console_log" {
    value = "gcloud compute instances get-serial-port-output \"${google_compute_instance.bench.name}\" --zone \"${google_compute_instance.bench.zone}\""
}

output "web_console_log" {
    value = "gcloud compute instances get-serial-port-output \"${google_compute_instance.web.name}\" --zone \"${google_compute_instance.web.zone}\""
}

