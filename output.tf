output "certificate_map_id" {
  value = module.tls_cert.certificate_map_id
  description = "Certificate Map ID"
}

output "ssl_certificates" {
  value       = module.tls_cert.ssl_certificates
  description = "Certificate field"
}