output "bench_address" {
    value = module.gce_bench.network_interface[0][0].access_config.0.nat_ip
}

output "web_address" {
    value = module.gce_web.network_interface.*.0.access_config.0.nat_ip
}

