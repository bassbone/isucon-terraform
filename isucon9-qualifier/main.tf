provider "google" {}

resource "google_compute_network" "default" {
    name = var.name
}

resource "google_compute_firewall" "ssh" {
    name = "${var.name}-ssh"
    network = google_compute_network.default.name
    allow {
        protocol = "tcp"
        ports = ["22"]
    }

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["${var.name}-bench", "${var.name}-web"]
}

resource "google_compute_firewall" "https" {
    name = "${var.name}-https"
    network = google_compute_network.default.name
    allow {
        protocol = "tcp"
        ports = ["443"]
    }

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["${var.name}-web"]
}

resource "google_compute_instance" "bench" {
    name = "${var.name}-bench"
    machine_type = var.bench_machine_type
    boot_disk {
        initialize_params {
            size  = 20
            type  = "pd-standard"
            image = var.disk_image
        }
    }
    zone = var.zone
    tags = ["${var.name}-bench"]
    network_interface {
        network = google_compute_network.default.name
        access_config { }
    }
    metadata_startup_script = <<SCRIPT
#!/bin/sh
apt-get update
apt-get -y install ansible git language-pack-ja docker.io build-essential unzip
update-locale LANG=ja_JP.UTF-8
git clone https://github.com/isucon/isucon9-qualify.git
(
    cd isucon9-qualify/initial-data
    make
)
apt-get remove docker.io
(
    cd isucon9-qualify/provisioning
    sed -i -e 's/1001/2001/g' roles/user.isucon/tasks/main.yml
    echo "[bench]\nlocalhost ansible_connection=local" > local
    echo "[defaults]\nremote_tmp = /root/.ansible/tmp" > ansible.cfg
    ansible-playbook -i local bench.yml
)
(
    cd /home/isucon/isucari/webapp/public
    wget -q https://github.com/isucon/isucon9-qualify/releases/download/v2/initial.zip
    unzip -q initial.zip
    rm -rf upload
    mv v3_initial_data upload
)
(
    cd isucon9-qualify/initial-data
    wget -q https://github.com/isucon/isucon9-qualify/releases/download/v2/bench1.zip
    unzip -q bench1.zip
    rm -rf images
    mv v3_bench1 images
)
SCRIPT
}

resource "google_compute_instance" "web" {
    name = "${var.name}-web"
    machine_type = var.web_machine_type
    boot_disk {
        initialize_params {
            size  = 20
            type  = "pd-standard"
            image = var.disk_image
        }
    }
    zone = var.zone
    tags = ["${var.name}-web"]
    network_interface {
        network = google_compute_network.default.name
        access_config { }
    }
    metadata_startup_script = <<SCRIPT
#!/bin/sh
apt-get update
apt-get -y install ansible git language-pack-ja docker.io build-essential unzip
update-locale LANG=ja_JP.UTF-8
git clone https://github.com/isucon/isucon9-qualify.git
(
    cd isucon9-qualify/initial-data
    make
)
apt-get remove docker.io
(
    cd isucon9-qualify/provisioning
    sed -i -e 's/1001/2001/g' roles/user.isucon/tasks/main.yml
    echo "[webapp]\nlocalhost ansible_connection=local" > local
    echo "[defaults]\nremote_tmp = /root/.ansible/tmp" > ansible.cfg
    ansible-playbook -i local webapp.yml
)
(
    cd /home/isucon/isucari/webapp/public
    wget -q https://github.com/isucon/isucon9-qualify/releases/download/v2/initial.zip
    unzip -q initial.zip
    rm -rf upload
    mv v3_initial_data upload
)
(
    cd isucon9-qualify/initial-data
    wget -q https://github.com/isucon/isucon9-qualify/releases/download/v2/bench1.zip
    unzip -q bench1.zip
    rm -rf images
    mv v3_bench1 images
)
SCRIPT
}
