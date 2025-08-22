variable "sub_domain" {
  type        = string
  description = "Subdomain the FQDN will be <subdomain>.<base_domain>"
}

variable "base_domain" {
  type        = string
  description = "THe base domain, the FQDN will be <subdomain>.<base_domain>"
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
  default     = "A"
  description = "Record type"
}



resource "google_dns_record_set" "this" {
  project      = var.dns_project_name
  managed_zone = var.dns_zone_name
  name         = "${var.sub_domain}.${var.base_domain}."
  type         = var.record_type
  ttl          = 60
  rrdatas      = var.rrdatas
}

output "domain_name" {
  value       = google_dns_record_set.this.name
  description = "record_set"
}