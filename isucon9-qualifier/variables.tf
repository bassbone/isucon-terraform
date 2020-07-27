variable "zone" {
    description = "gcloud compute zones list"
    default = "asia-northeast1-a"
    #default = "asia-east1-b"
    #default = "asia-east1-c"
    #default = "us-central1-a"
    #default = "us-central1-b"
    #default = "us-central1-c"
    #default = "us-central1-f"
}

variable "bench_machine_type" {
    description = "gcloud compute machine-types list"
    #default = "f1-micro"
    #default = "g1-small"
    #default = "n1-standard-1"
    #default = "n1-highcpu-2"
    #default = "n1-highcpu-4"
    default = "custom-2-4096"
}

variable "web_machine_type" {
    description = "gcloud compute machine-types list"
    #default = "f1-micro"
    #default = "g1-small"
    #default = "n1-standard-1"
    #default = "n1-highcpu-2"
    #default = "n1-highcpu-4"
    default = "custom-2-4096"
}

variable "disk_image" {
    description = "gcloud compute images list"
    default = "ubuntu-1804-bionic-v20200701"
}

variable "name" {
    default = "isucon9-qualifier"
}

