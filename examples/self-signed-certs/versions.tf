# ==========================================
# Example to manage self-signed certificates
# ==========================================


# -------------------
# Module Dependencies
# -------------------

terraform {
  required_version = ">= 0.13"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.26"
    }

    tls    = {
      source  = "hashicorp/tls"
      version = ">= 2.1"
    }
  }
}
