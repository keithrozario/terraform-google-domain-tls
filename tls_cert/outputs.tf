output "certificate_map_id" {
  value = google_certificate_manager_certificate_map.this.id
}

output "ssl_certificates" {
  value       = "//certificatemanager.googleapis.com/${google_certificate_manager_certificate_map.this.id}"
  description = "Certificate field"
}