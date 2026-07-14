locals {
  map_name = var.sub_domains[0]
}

resource "google_certificate_manager_dns_authorization" "this" {
  for_each    = toset(var.sub_domains)
  name        = "${each.key}-dns-auth"
  location    = "global"
  description = each.key
  domain      = "${each.key}.${var.base_domain}"
}

resource "google_dns_record_set" "this" {
  for_each     = toset(var.sub_domains)
  project      = var.dns_project_name
  managed_zone = var.dns_zone_name
  name         = google_certificate_manager_dns_authorization.this[each.key].dns_resource_record.0.name
  type         = google_certificate_manager_dns_authorization.this[each.key].dns_resource_record.0.type
  ttl          = 5
  rrdatas = [
    google_certificate_manager_dns_authorization.this[each.key].dns_resource_record.0.data
  ]
}

resource "google_certificate_manager_certificate" "this" {
  for_each    = toset(var.sub_domains)
  name        = "${each.key}-cert"
  description = "Cert issued by Terraform"
  scope       = "DEFAULT"
  managed {
    domains = [
      google_certificate_manager_dns_authorization.this[each.key].domain
    ]
    dns_authorizations = [
      google_certificate_manager_dns_authorization.this[each.key].id
    ]
  }
}

resource "google_certificate_manager_certificate_map" "this" {
  name        = local.map_name
  description = "Certificate map for subdomains: ${join(", ", var.sub_domains)}"
}

resource "google_certificate_manager_certificate_map_entry" "primary" {
  name         = local.map_name
  map          = google_certificate_manager_certificate_map.this.name
  certificates = [google_certificate_manager_certificate.this[local.map_name].id]
  matcher      = "PRIMARY"
}

resource "google_certificate_manager_certificate_map_entry" "subdomains" {
  for_each     = toset(slice(var.sub_domains, 1, length(var.sub_domains)))
  name         = each.key
  map          = google_certificate_manager_certificate_map.this.name
  certificates = [google_certificate_manager_certificate.this[each.key].id]
  hostname     = "${each.key}.${var.base_domain}"
}