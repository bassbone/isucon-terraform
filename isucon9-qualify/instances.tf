module "gce_bench" {
    source = "./instance"
    name = "${var.name}-bench"
    tags = "${var.name}-bench"
    network_name = google_compute_network.default.name
    subnetwork_name = google_compute_subnetwork.default.name
    metadata_startup_script = file("./startup-script/startup-script-bench.sh")
    node_count = var.bench-count
    static_ip = google_compute_address.static_ip_bench
    offset = 201
    #disk_image = "isucon9-qualifier-bench"
    machine_type = "custom-2-4096"
}

module "gce_web" {
    source = "./instance"
    name = "${var.name}-web"
    tags = "${var.name}-web"
    network_name = google_compute_network.default.name
    subnetwork_name = google_compute_subnetwork.default.name
    metadata_startup_script = file("./startup-script/startup-script-web.sh")
    node_count = var.web-count
    static_ip = google_compute_address.static_ip_web
    offset = 101
    #disk_image = "isucon9-qualifier-web"
    machine_type = "custom-2-4096"
}

