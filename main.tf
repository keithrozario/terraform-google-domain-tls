module "dns_record" {
  source           = "./domain_entry"
  sub_domain       = var.sub_domain
  rrdatas          = var.rrdatas
  base_domain      = var.base_domain
  dns_project_name = var.dns_project_name
  dns_zone_name    = var.dns_zone_name
  record_type      = "A"
}

module "tls_cert" {
  source            = "./tls_cert"
  sub_domain         = var.sub_domain
  regional_location = var.region
  base_domain       = var.base_domain
  dns_project_name  = var.dns_project_name
  dns_zone_name     = var.dns_zone_name
}

