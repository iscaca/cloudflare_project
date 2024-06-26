terraform {
  required_providers {
    cloudflare = {
        source = "cloudflare/cloudflare"
        version = "~> 4.0"
    }
  }
}

module "new_zones" {
    source            = "./modules/new_zones"
    partial_dns_batch = var.partial_dns_batch
    account_id        = var.account_id
  
}

module "dns" {
    source        = "./modules/zones_params/dns"
    dns_records   = var.dns_records
    dns_records_a = var.dns_records_a
  
}

module "lists" {
  source        = "./modules/zones_params/lists"
  account_id    = var.account_id
  
}

module "logpush" {
  source = "./modules/zones_params/logpush"
  zones_names_ids = var.zone_names_ids
  account_id      = var.account_id
  
}

module "rate_limit" {
  source = "./modules/zones_params/rate_limit"
  zones_names_ids = var.zone_names_ids
  
}

module "waf_account_level" {
  source = "./modules/zones_params/raf_account_level"
  account_id = var.account_id
  
}
