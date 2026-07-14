variable "sub_domains" {
  type        = list(string)
  description = "Subdomains list"
}

variable "base_domain" {
  type        = string
  description = "The base domain"
}

variable "rrdatas" {
  type        = list(string)
  description = "rrdatas of the subdomain"
}

variable "dns_project_name" {
  type        = string
  description = "Google Cloud project id with dns delegation"
}

variable "dns_zone_name" {
  type        = string
  description = "Argolis zone name id with dns delegation"
}

variable "record_type" {
  type        = string
  default     = "A"
  description = "Record type"
}

resource "google_dns_record_set" "this" {
  for_each     = toset(var.sub_domains)
  project      = var.dns_project_name
  managed_zone = var.dns_zone_name
  name         = "${each.key}.${var.base_domain}."
  type         = var.record_type
  ttl          = 60
  rrdatas      = var.rrdatas
}

output "domain_name" {
  value       = length(google_dns_record_set.this) > 0 ? values(google_dns_record_set.this)[0].name : ""
  description = "Primary record_set"
}

output "domain_names" {
  value       = [for r in google_dns_record_set.this : r.name]
  description = "List of record_set names"
}