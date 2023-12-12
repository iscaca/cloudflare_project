terraform {
  required_providers {
    cloudflare = {
        source = "cloudflare/cloudflare"
        version = "~> 3.0"
    }
  }
}

resource "cloudflare_list" "ip_list" {
    account_id =  var.account_id
    name = "stack_ip_list"
    kind = "ip"
    description = ""

    item {
      value { ip = "" }
    }
  
}