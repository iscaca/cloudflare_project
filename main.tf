terraform {
  required_providers {
    cloudflare = {
        source = "cloudflare/cloudflare"
        version = "~> 3.0"
    }
  }
}

module "new_zones" {
    source = "./modules/new_zones"
    partial_dns_batch = var.partial_dns_batch
    account_id = var.account_id
  
}

module "dns" {
    source = "./modules/zones_params/dns"
    dns_records = var.dns_records
    dns_records_a = var.dns_records_a
  
}