terraform {
  required_providers {
    cloudflare = {
        source = "cloudflare/cloudflare"
        version = "~> 3.0"
    }
  }
}

resource "cloudflare_ruleset" "account_level_ratelimiting_rule" {
    account_id  = var.account_id
    name        = "Rate limit ruleset"
    description = ""
    kind        = "custom"
    phase       = "http_ratelimit"

    rules {
        action = "block"
        ratelimit {
          characteristics     = ["cf.colo.id", "ip.src"]
          period              = 60
          requests_per_period = 1000
          mitigation_timeout  = 120
        }
        expression  = "(http.request.uri.path matches \"^/*\" and not ip.geoip.asnum in {} )"
        description = ""
        enabled     = true
    } 

    rules {
        action = "managed_challenge"
        ratelimit {
          characteristics     = ["cf.colo.id", "ip.src"]
          period              = 60
          requests_per_period = 500
          mitigation_timeout  = 120
        }
        expression  = "(http.request.uri.path matches \"^/*\" and not ip.geoip.asnum in {} )"
        description = ""
        enabled     = true
    } 
  
}