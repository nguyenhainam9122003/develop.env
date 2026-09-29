# Ví dụ minh hoạ cấu trúc Terraform quản lý hạ tầng GCP (GKE cluster) qua GitOps.
# File này CHƯA được apply — chỉ để học cấu trúc. Cần điền project_id thật
# và chạy `terraform init && terraform plan` trước khi cân nhắc apply.

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

variable "project_id" {
  description = "GCP project id"
  type        = string
}

variable "region" {
  default = "asia-southeast1"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "primary" {
  name     = "learning-cluster"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-pool"
  cluster    = google_container_cluster.primary.name
  location   = var.region
  node_count = 1

  node_config {
    machine_type = "e2-small"
  }
}
