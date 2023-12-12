#root variables

variable "cloudflare_api_token" {
    type = string
    sensitive   = true
    description = "Cloudflare API Token"
}

variable "account_id" {
    type = string
    sensitive   = true
    description = "Account ID"
}

variable "zone_names_ids" {
  type = list(object({
    zone_id = string
    zone    = string 
  }))
}

variable "partial_dns_batch" {
    type = list(object({
      zone = string
      type = string 
    }))
  
}

variable "dns_records" {
  type = list(object({
    zone_id     = string
    cname_name  = string
    cname_value = string 
  }))
}

variable "dns_records_a" {
    type = list(object({
      zone_id = string
      name    = string
      value   = string
    }))
  
}