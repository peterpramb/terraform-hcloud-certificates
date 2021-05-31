# ========================================
# Manage certificates in the Hetzner Cloud
# ========================================


# ---------------
# Input Variables
# ---------------

variable "certificates" {
  description = "The list of certificate objects to be managed. Each certificate object supports the following parameters: 'name' (string, required), 'certificate' (string, required if imported), 'private_key' (string, required if imported), 'domains' (list of domain names, required if managed), 'labels' (map of KV pairs, optional)."

  type        = list(
    object({
      name        = string
      certificate = string
      private_key = string
      domains     = list(string)
      labels      = map(string)
    })
  )

  default     = [
    {
      name        = "certificate-1"
      certificate = null
      private_key = null
      domains     = [
        "*.example.net"
      ]
      labels      = {}
    }
  ]

  validation {
    condition     = can([
      for cert in var.certificates : regex("\\w+", cert.name)
    ])
    error_message = "All certificates must have a valid 'name' attribute specified."
  }

  validation {
    condition     = can([
      for cert in var.certificates : regex("\\w+", cert.certificate)
        if(try(cert.domains, 0) == 0)
    ])
    error_message = "Imported certificates must have a valid 'certificate' attribute specified."
  }

  validation {
    condition     = can([
      for cert in var.certificates : regex("\\w+", cert.private_key)
        if(try(cert.domains, 0) == 0)
    ])
    error_message = "Imported certificates must have a valid 'private_key' attribute specified."
  }

  validation {
    condition     = can([
      for cert in var.certificates : element(cert.domains, 0)
        if(try(cert.certificate, "") == "" && try(cert.private_key, "") == "")
    ])
    error_message = "Managed certificates must have at least one domain name specified."
  }

  validation {
    condition     = can([
      for cert in var.certificates : [
        for domain in cert.domains : regex("\\w+", domain)
      ] if(try(cert.certificate, "") == "" && try(cert.private_key, "") == "")
    ])
    error_message = "Managed certificates must have valid domain names specified."
  }
}
