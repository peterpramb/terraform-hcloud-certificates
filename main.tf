# ========================================
# Manage certificates in the Hetzner Cloud
# ========================================


# ------------
# Local Values
# ------------

locals {
  # Build a map of all provided certificate objects, indexed by certificate name:
  certificates = {
    for cert in var.certificates : cert.name => cert
  }

  # Build a map of all provided certificate objects to be imported, indexed by
  # certificate name:
  import_certs = {
    for name, cert in local.certificates : name => merge(cert, {
      "certificate" = trimspace(cert.certificate)
      "private_key" = trimspace(cert.private_key)
    }) if(try(length(cert.domains), 0) == 0)
  }

  # Build a map of all provided certificate objects to be managed, indexed by
  # certificate name:
  manage_certs = {
    for name, cert in local.certificates : name => cert
      if(try(length(cert.domains), 0) > 0)
  }
}


# ------------
# Certificates
# ------------

resource "hcloud_uploaded_certificate" "certificates" {
  for_each     = local.import_certs

  name         = each.value.name
  certificate  = each.value.certificate
  private_key  = each.value.private_key

  labels       = each.value.labels
}

resource "hcloud_managed_certificate" "certificates" {
  for_each     = local.manage_certs

  name         = each.value.name
  domain_names = each.value.domains

  labels       = each.value.labels
}
