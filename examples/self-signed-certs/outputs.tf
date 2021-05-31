# ==========================================
# Example to manage self-signed certificates
# ==========================================


# -------------
# Output Values
# -------------

output "certificates" {
  description = "A list of all certificate objects."
  value       = module.certificate.certificates
}
