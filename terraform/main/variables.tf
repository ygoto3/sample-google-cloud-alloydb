variable "credentials" {}

variable "project" {}
variable "region" {}
variable "region_secondary" {}
variable "zone" {}

variable "network_name" {
    default = "sample-alloydb-network"
}

variable "subnetwork_name" {
    default = "sample-alloydb-subnetwork"  
}

variable "instance_name" {
    default = "sample-app-instance"
}
variable "machine_type" {
    default = "e2-micro"
}
variable "image" {
    default = "debian-cloud/debian-12"
}
