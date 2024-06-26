terraform {
  required_providers {
    cloudflare = {
        source = "cloudflare/cloudflare"
        version = "~> 4.0"
    }
  }
}

variable "zones_names_ids" {
  type = list(object({
    zone_id = string
    zone    = string
  }))
  
}

resource "cloudflare_ruleset" "zone_level_rate_limit" {
    for_each    = { for entry in var.zones_names_ids : "${entry.zone_id}.${entry.zone}" => entry }
    zone_id     = each.value.zone_id
    name        = "Rate Limit Ruleset"
    description = ""
    kind        = "zone"
    phase       = "http_ratelimit"

    rules {
        action = "challenge"
        ratelimit {
          characteristics = ["cf.colo.id", "ip.src"]
          period = 60
          requests_per_period = 1000
          mitigation_timeout = 0
        }
        expression = "(http.request.uri.path matches \"/*\")"
        description = "Default Rate limiting rule"
        enabled = true
    } 
  
      rules {
        action = "block"
        ratelimit {
          characteristics = ["cf.colo.id", "ip.src"]
          period = 60
          requests_per_period = 1000
          mitigation_timeout = 60
        }
        expression = "(http.request.uri.path matches \"/*\")"
        description = "Default Rate limiting rule"
        enabled = true
    } 
}