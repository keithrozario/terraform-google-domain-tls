variable "enable_custom_domain" {
  type    = bool
  default = false
}

variable "base_domain" {
  type        = string
  description = "Base domain for the custom domain. The FQDN is <sub_domain>.<base_domain>"
}

variable "sub_domain" {
  type        = string
  description = "Single subdomain (legacy, please use sub_domains instead)"
  default     = ""
}

variable "sub_domains" {
  type        = list(string)
  description = "List of subdomains to include in the certificate map and DNS entries"
  default     = []
}

variable "dns_project_name" {
  type        = string
  description = "GCP project that contains the DNS ZONE in Cloud DNS"
}

variable "dns_zone_name" {
  type        = string
  default     = ""
  description = "Name of DNS ZONE in Cloud DNS"
}

variable "region" {
  type = string
  description = "GCP Region for TLS Certificates"
}

variable "rrdatas" {
  type = list(string)
  description = "rrdatas for dns entry"
}

variable "record_type" {
  type = string
  description = "record type for dns entry"
  default = "A"
}
