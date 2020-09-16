resource "google_compute_address" "static_ip_bench" {
    count = var.bench-count
    name = "${var.name}-static-ip-bench-${count.index}"
    region = var.bench-region
}

resource "google_compute_address" "static_ip_web" {
    count = var.web-count
    name = "${var.name}-static-ip-web-${count.index}"
    region = var.web-region
}

