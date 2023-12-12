variable "account_id" {
    type = string
  
}

variable "zones_names_ids" {
    type = list(object({
      zone_id = string
      zone    = string
    }))
  
}