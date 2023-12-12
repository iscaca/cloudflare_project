terraform {
  required_providers {
    cloudflare = {
        source = "cloudflare/cloudflare"
        version = "~> 3.0"
    }
  }
}

resource "cloudflare_record" "new_record_a" {
    # We need a map to use for_each, so we convert our list into a map by adding a unique key:
    for_each = { for entry in var.dns_records_a : "${entry.zone_id}.${entry.name}.${entry.value}" =>entry }
    zone_id = each.value.zone_id
    name = each.value.name
    value = each.value.value
    type = "A"
    proxied = true
      
}

resource "cloudflare_record" "new_record" {
    # We need a map to use for_each, so we convert our list into a map by adding a unique key:
    for_each = { for entry in var.dns_records : "${entry.zone_id}.${entry.cname_name}.${entry.cname_value}" =>entry }
    zone_id = each.value.zone_id
    name = each.value.cname_name
    value = each.value.cname_value
    type = "CNAME"
    proxied = true
      
}