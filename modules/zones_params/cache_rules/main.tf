terraform {
  required_providers {
    cloudflare = {
        source = "cloudflare/cloudflare"
        version = "~> 4.0"
    }
  }
}

resource "cloudflare_ruleset" "cache_settings_example" {
  zone_id     = "0da42c8d2132a9ddaf714f9e7c920711"
  name        = "set cache settings"
  description = "set cache settings for the request"
  kind        = "zone"
  phase       = "http_request_cache_settings"

  rules {
    action = "set_cache_settings"
    action_parameters {
      edge_ttl {
        mode    = "respect_origin"
      }
      browser_ttl {
        mode = "respet_origin"
      }
    }
    expression = ""
    description = ""
    enabled = true
  }

}