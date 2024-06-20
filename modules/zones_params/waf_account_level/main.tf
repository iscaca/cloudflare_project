terraform {
  required_providers {
    cloudflare = {
        source = "cloudflare/cloudflare"
        version = "~> 4.0"
    }
  }
}

variable "account_id" {
    type = string
  
}
resource "cloudflare_ruleset" "account_custom_rules" {
    account_id = var.account_id
    kind       = "custom"
    name       = "account_custom_rules"
    phase      = "http_request_firewall_custom"

    rules {
      action      = "block"
      description = "bot_score_1"
      enabled     = true
      expression  = "(cf.bot_management.score eq 1 not cf.bot_managemenet.verified_bot and ip.geoip.asnum in {} )"
    }

    rules {
      action      = "log"
      description = "bot_score_2_5"
      enabled     = true
      expression  = "(cf.bot_management.score ge 2 and cf.bot_managemenet.score lt 5 and not cf.bot_management.verified_bot)"
      } 
     

    rules {
      action      = "log"
      description = "bot_score_5_20"
      enabled     = true
      expression  = "(cf.bot_management.score ge 5 and cf.bot_managemenet.score lt 20 and not cf.bot_management.verified_bot)"
      } 
     
    rules {
      action      = "log"
      description = "bot_score_20_30"
      enabled     = true
      expression  = "(cf.bot_management.score ge 20 and cf.bot_managemenet.score lt 30 and not cf.bot_management.verified_bot)"
      } 
     
  
}