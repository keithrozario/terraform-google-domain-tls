# Terraform Domain Entry and TLS Cert module

This module is meant to simplfy the creation of a domain entry and TLS Certifcate especially if the DNS management is delegated to another google cloud project.

# Usage

```hcl
module "tf_domain_and_tls" {
    source           = "keithrozario/domain-tls/google"
    sub_domain       = "sub"
    rrdatas          = ["123.4.5.6"]
    record_type      = "A"
    base_domain      = "example.com"
    dns_project_name = "project-123"
    dns_zone_name    = "zone-123"
    region           = "us-central1"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| sub_domain | The Subdomain of the FQDN to deploy  | string | none | yes|
| rrdatas | The rrdata field to enter in the DNS entry. e.g. ["123.4.5.6","234.5.6.7"] | list(str) | none | yes
| record_type | The record type of the DNS entry. | string | "A" | no
| base_domain | The base domain of the FQDN to deploy | string | none | yes
| dns_project_name | The GCP Project ID that contains the DNS ZONE in Cloud DNS | string | none | yes
| dns_zone_name | The name of the DNS ZONE in Cloud DNS | string | none | yes
| region | The region to deploy the certificate in | string | none | yes


## Outputs

| Name | Description | Type |
|------|-------------|------|
| certificate_map_id | The Certficate Map ID created for the certificate | string | 
| ssl_certificates | The SSL Certificate Location beginning with `/certificatemanager.googleapis.com/`| string |
