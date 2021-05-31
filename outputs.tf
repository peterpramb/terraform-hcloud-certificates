# ========================================
# Manage certificates in the Hetzner Cloud
# ========================================


# ------------
# Local Values
# ------------

locals {
  output_certificates = [
    for cert in merge(
      {
        for name, cert in hcloud_uploaded_certificate.certificates :
          name => merge(cert, {
            "private_key" = null
          })
      },
      hcloud_managed_certificate.certificates
    ) : cert
  ]
}


# -------------
# Output Values
# -------------

output "certificates" {
  description = "A list of all certificate objects."
  value       = local.output_certificates
}

output "certificate_ids" {
  description = "A map of all certificate objects indexed by ID."
  value       = {
    for cert in local.output_certificates : cert.id => cert
  }
}

output "certificate_names" {
  description = "A map of all certificate objects indexed by name."
  value       = {
    for cert in local.output_certificates : cert.name => cert
  }
}
