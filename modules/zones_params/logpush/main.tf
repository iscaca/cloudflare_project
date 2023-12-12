terraform {
  required_providers {
    cloudflare = {
        source = "cloudflare/cloudflare"
        version = "~> 3.0"
    }
    aws = {
        source = "hashicorp/aws"
    }
  }
}

resource "cloudflare_logpush_ownership_challenge" "challenge_http_request" {
    for_each            = { for entry in var.zones_names_ids : "${entry.zone_id}.${entry.zone}" => entry }
    zone_id             = each.value.zone_id
    destination_conf    = "s3://cloudflare-logpush/logs/${var.account_id}/${each.value.zone}/http_requests/?region=us-east-2" 
}
data "aws_s3_bucket_object" "challenge_file_http_requests" {
    for_each            = { for entry in var.zones_names_ids : "${entry.zone_id}.${entry.zone}" => entry }
    bucket              = "cloudflare_logpush"
    key                 = cloudflare_logpush_ownership_challenge.challenge_http_request[each.key].ownership_challenge_filename
}

resource "cloudflare_logpush_ownership_challenge" "nel_reports_request" {
    for_each            = { for entry in var.zones_names_ids : "${entry.zone_id}.${entry.zone}" => entry }
    zone_id             = each.value.zone_id
    destination_conf    = "s3://cloudflare-logpush/logs/${var.account_id}/${each.value.zone}/nel_reports/?region=us-east-2" 
}
data "aws_s3_bucket_object" "challenge_file_nel_reports" {
    for_each            = { for entry in var.zones_names_ids : "${entry.zone_id}.${entry.zone}" => entry }
    bucket              = "cloudflare_logpush"
    key                 = cloudflare_logpush_ownership_challenge.nel_reports_request[each.key].ownership_challenge_filename
}

resource "cloudflare_logpush_ownership_challenge" "challenge_firewall_events" {
    for_each            = { for entry in var.zones_names_ids : "${entry.zone_id}.${entry.zone}" => entry }
    zone_id             = each.value.zone_id
    destination_conf    = "s3://cloudflare-logpush/logs/${var.account_id}/${each.value.zone}/http_requests/?region=us-east-2" 
}
data "aws_s3_bucket_object" "challenge_file_firewall_events" {
    for_each            = { for entry in var.zones_names_ids : "${entry.zone_id}.${entry.zone}" => entry }
    bucket              = "cloudflare_logpush"
    key                 = cloudflare_logpush_ownership_challenge.challenge_firewall_events[each.key].ownership_challenge_filename
}

resource "cloudflare_logpush_job" "http_requests_job" {
    enabled             = true
    for_each            = { for entry in var.zones_names_ids : "${entry.zone_id}.${entry.zone}" => entry }
    name                = "cf-logpush-s3"
    logpull_options     = "fields=ClientIP,ClientRequestHost,ClientRequestMethod,ClientRequestURI,EdgeEndTimestamp,EdgeResponseBytes,EdgeResponseStatus,EdgeStartTimestamp,RayID&timestamps=rfc3339"
    destination_conf    = "s3://cloudflare-logpush/logs/${var.account_id}/${each.value.zone}/http_requests/?region=us-east-2"
    ownership_challenge = data.aws_s3_bucket_object.challenge_file_http_requests[each.key].body
    dataset             = "http_reports"
  
}

resource "cloudflare_logpush_job" "nel_reports_job" {
    enabled             = true
    for_each            = { for entry in var.zones_names_ids : "${entry.zone_id}.${entry.zone}" => entry }
    name                = "cf-logpush-s3"
    logpull_options     = "fields=Phase,Timestamp,Type&timestamps=unixnano"
    destination_conf    = "s3://cloudflare-logpush/logs/${var.account_id}/${each.value.zone}/nel_reports/?region=us-east-2"
    ownership_challenge = data.aws_s3_bucket_object.challenge_file_nel_reports[each.key].body
    dataset             = "http_reports"
  
}

resource "cloudflare_logpush_job" "firewall_events_job" {
    enabled             = true
    for_each            = { for entry in var.zones_names_ids : "${entry.zone_id}.${entry.zone}" => entry }
    name                = "cf-logpush-s3"
    logpull_options     = "fields=Action,Datetime,Description,RayId,ClientIp,ClientRequestHost,ClientRequestMethod,ClientRequestPath,ClientRequestQuery,EdgeResponseStatus&timestamps=unixnano"
    destination_conf    = "s3://cloudflare-logpush/logs/${var.account_id}/${each.value.zone}/nel_reports/?region=us-east-2"
    ownership_challenge = data.aws_s3_bucket_object.challenge_file_firewall_events[each.key].body
    dataset             = "http_reports"
  
}