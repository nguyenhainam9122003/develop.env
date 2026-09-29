# Ví dụ minh hoạ: Terraform quản lý policy/secret-engine trong Vault
# (giả định Vault server đã có sẵn — chạy dev-mode local để học ở phần kubernetes/ hoặc laptop riêng).
# File này CHƯA được apply.

terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.0"
    }
  }
}

variable "vault_addr" {
  default = "http://vault.vault.svc:8200"
}

provider "vault" {
  address = var.vault_addr
}

resource "vault_mount" "kv" {
  path = "secret"
  type = "kv-v2"
}

resource "vault_policy" "pet_be_read" {
  name   = "pet-be-read"
  policy = <<-EOT
    path "secret/data/pet-be/*" {
      capabilities = ["read"]
    }
  EOT
}
