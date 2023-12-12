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