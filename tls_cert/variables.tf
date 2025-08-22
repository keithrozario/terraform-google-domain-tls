variable "regional_location" {
  type        = string
  description = "location of additional regional tls certificate"
}

variable "sub_domain" {
  type        = string
  description = "Subdomain the FQDN will be <subdomain>.<base_domain>"
}

variable "base_domain" {
  type        = string
  description = "THe base domain, the FQDN will be <subdomain>.<base_domain>"
}

variable "dns_project_name" {
  type        = string
  description = "Google Cloud project id with dns delegation"
}

variable "dns_zone_name" {
  type        = string
  description = "Argolis zone name id with dns delegation"
}