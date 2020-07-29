module "gce_bench" {
    source = "./instance"
    name = "${var.name}-bench"
    tags = "${var.name}-bench"
    network_name = google_compute_network.default.name
    metadata_startup_script = file("startup-script-bench.sh")
}

module "gce_web" {
    source = "./instance"
    name = "${var.name}-web"
    tags = "${var.name}-web"
    network_name = google_compute_network.default.name
    metadata_startup_script = templatefile("startup-script-web.sh", { bench-ip = "${module.gce_bench.network_interface.0.access_config.0.nat_ip}" })
}

