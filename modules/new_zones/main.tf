terraform {
  required_providers {
    cloudflare = {
        source = "cloudflare/cloudflare"
        version = "~> 3.0"
    }
  }
}

resource "cloudflare_zone" "partial_dns_batch" {
    account_id = var.account_id
    for_each = { for each in var.partial_dns_batch : "$(each.zone)" => each }
    zone = each.value.zone
    plan = ""
    type = each.value.type
  
}