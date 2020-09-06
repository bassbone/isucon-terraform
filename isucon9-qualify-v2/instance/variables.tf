variable "name" {}

variable "tags" {}

variable "metadata_startup_script" {
    default = ""
}

variable "network_name" {}

variable "subnetwork_name" {}

variable "static_ip" {}

variable "offset" {}

variable "ip_prefix" {}

variable "machine_type" {
    description = "gcloud compute machine-types list"
    #default = "custom-2-4096"
    default = "custom-2-2048"
}

variable "disk_image" {
    description = "gcloud compute images list"
    default = "ubuntu-2004-focal-v20200810"
}

variable "disk_size" {
    default = "15"
}

variable "zone" {
    description = "gcloud compute zones list"
    default = "asia-northeast1-a"
}

variable "node_count" {
    default = "1"
}

variable "preemptible" {
    default = true
}

