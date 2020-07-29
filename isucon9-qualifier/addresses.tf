resource "google_compute_address" "static_ip_bench" {
    count = var.bench-count
    name = "static-ip-bench-${count.index}"
    region = var.region
}

resource "google_compute_address" "static_ip_web" {
    count = var.web-count
    name = "static-ip-web-${count.index}"
    region = var.region
}

