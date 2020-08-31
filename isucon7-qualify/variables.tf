variable "name" {
    default = "isucon7-qualifier"
}

variable "bench-count" {
    default = 1
}

variable "web-count" {
    #default = 1
    default = 3
}

variable "bench-region" {
    description = "gcloud compute regions list"
    default = "asia-northeast1"
}

variable "web-region" {
    description = "gcloud compute regions list"
    default = "asia-northeast1"
}

variable "bench-ip-prefix" {
    default = "10.0.2"
}

variable "web-ip-prefix" {
    default = "10.0.1"
}

