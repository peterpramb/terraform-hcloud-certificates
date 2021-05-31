# ==========================================
# Example to manage self-signed certificates
# ==========================================


# ------------
# Local Values
# ------------

locals {
  # Enrich user configuration for certificate module:
  certificates = [
    for name, cert in tls_self_signed_cert.self_signed : {
      "name"        = name
      "certificate" = cert.cert_pem
      "private_key" = tls_private_key.self_signed.private_key_pem
      "domains"     = null
      "labels"      = var.labels
    }
  ]
}


# --------
# Generate
# --------

resource "tls_private_key" "self_signed" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_self_signed_cert" "self_signed" {
  for_each              = {
    for cn in var.subject_cns : cn => {}
  }

  key_algorithm         = tls_private_key.self_signed.algorithm
  private_key_pem       = tls_private_key.self_signed.private_key_pem
  validity_period_hours = var.validity
  allowed_uses          = [
    "digital_signature",
    "key_encipherment",
    "server_auth"
  ]

  subject {
    organization = "Example Org"
    common_name  = each.key
  }
}


# ------------
# Certificates
# ------------

module "certificate" {
  source       = "github.com/peterpramb/terraform-hcloud-certificates"

  certificates = local.certificates
}
