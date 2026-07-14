locals {
  all_sub_domains = distinct(compact(concat(
    var.sub_domain != "" && var.sub_domain != null ? [var.sub_domain] : [],
    var.sub_domains
  )))
}

module "dns_record" {
  source           = "./domain_entry"
  sub_domains      = local.all_sub_domains
  rrdatas          = var.rrdatas
  base_domain      = var.base_domain
  dns_project_name = var.dns_project_name
  dns_zone_name    = var.dns_zone_name
  record_type      = var.record_type
}

module "tls_cert" {
  source            = "./tls_cert"
  sub_domains       = local.all_sub_domains
  regional_location = var.region
  base_domain       = var.base_domain
  dns_project_name  = var.dns_project_name
  dns_zone_name     = var.dns_zone_name
}

