resource "google_certificate_manager_dns_authorization" "this" {
  name        = "${var.sub_domain}-dns-auth"
  location    = "global"
  description = var.sub_domain
  domain      = "${var.sub_domain}.${var.base_domain}"
}


resource "google_dns_record_set" "this" {
  project      = var.dns_project_name
  managed_zone = var.dns_zone_name
  name         = google_certificate_manager_dns_authorization.this.dns_resource_record.0.name
  type         = google_certificate_manager_dns_authorization.this.dns_resource_record.0.type
  ttl          = 5
  rrdatas = [
    google_certificate_manager_dns_authorization.this.dns_resource_record.0.data
  ]
}

resource "google_certificate_manager_certificate" "this" {
  name        = "${var.sub_domain}-cert"
  description = "Cert issued by Terraform"
  # Scope must be DEFAULT for Load Balancer
  scope = "DEFAULT"
  managed {
    domains = [
      google_certificate_manager_dns_authorization.this.domain
    ]
    dns_authorizations = [
      google_certificate_manager_dns_authorization.this.id
    ]
  }
}

resource "google_certificate_manager_certificate_map" "this" {
  name        = var.sub_domain
  description = var.sub_domain
}

resource "google_certificate_manager_certificate_map_entry" "this" {
  name         = var.sub_domain
  map          = google_certificate_manager_certificate_map.this.name
  certificates = [google_certificate_manager_certificate.this.id]
  matcher      = "PRIMARY"
}