# ==========================================
# Example to manage self-signed certificates
# ==========================================


# ---------------------
# Environment Variables
# ---------------------

# Hetzner Cloud Project API Token
# HCLOUD_TOKEN="<api_token>"


# ---------------
# Input Variables
# ---------------

variable "subject_cns" {
  description = "The list of subject CNs to issue certificates for."
  type        = list(string)
  default     = [
    "*.example.net"
  ]

  validation {
    condition     = can([
      element(var.subject_cns, 0)
    ])
    error_message = "At least one subject CN must be provided."
  }
}

variable "validity" {
  description = "The validity period of the certificates (in hours)."
  type        = number
  default     = 12
}

variable "labels" {
  description = "The map of labels to be assigned to all managed resources."
  type        = map(string)
  default     = {
    "managed"    = "true"
    "managed_by" = "Terraform"
  }
}
