variable "regional_location" {
  type        = string
  description = "location of additional regional tls certificate"
}

variable "sub_domains" {
  type        = list(string)
  description = "List of subdomains"
}

variable "base_domain" {
  type        = string
  description = "The base domain"
}

variable "dns_project_name" {
  type        = string
  description = "Google Cloud project id with dns delegation"
}

variable "dns_zone_name" {
  type        = string
  description = "Argolis zone name id with dns delegation"
}