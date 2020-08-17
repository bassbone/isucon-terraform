variable "name" {
    default = "isucon7-qualifier"
}

variable "bench-count" {
    default = 1
}

variable "web-count" {
    default = 1
    #default = 3
}

variable "region" {
    description = "gcloud compute regions list"
    default = "asia-northeast1"
}

