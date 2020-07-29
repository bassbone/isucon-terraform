output "bench_address" {
    value = "${module.gce_bench.network_interface.0.access_config.0.nat_ip}"
}

output "web_address" {
    value = "${module.gce_web.network_interface.0.access_config.0.nat_ip}"
}

output "bench_ssh" {
    value = "gcloud compute ssh \"${module.gce_bench.name}\" --zone \"${module.gce_bench.zone}\""
}

output "web_ssh" {
    value = "gcloud compute ssh \"${module.gce_web.name}\" --zone \"${module.gce_web.zone}\""
}

output "bench_console_log" {
    value = "gcloud compute instances get-serial-port-output \"${module.gce_bench.name}\" --zone \"${module.gce_bench.zone}\""
}

output "web_console_log" {
    value = "gcloud compute instances get-serial-port-output \"${module.gce_web.name}\" --zone \"${module.gce_web.zone}\""
}

