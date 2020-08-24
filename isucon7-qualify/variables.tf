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
    #default = "us-central1"
    default = "asia-northeast1"
}

variable "web-region" {
    description = "gcloud compute regions list"
    default = "asia-northeast1"
}

