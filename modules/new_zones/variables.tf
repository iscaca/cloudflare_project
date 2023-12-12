variable "partial_dns_batch" {
  type = list(object({
    zone = string
    type = string
  }))
}

variable "account_id" {
  type = string
}

