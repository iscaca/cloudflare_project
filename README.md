# Cloudflare Terraform Deployment

## Overview
This repository contains Terraform modules for deploying various Cloudflare resources. It's structured to provide easy management and deployment of resources like DNS records, new zones, SSL configurations, and more.

## Prerequisites
- Terraform v0.12+ 
- Cloudflare account with API Token

## Modules
The project is divided into several modules, each responsible for different aspects of Cloudflare resources:

- **DNS Module**: Handles the DNS records for domains.
- **New Zone Module**: Responsible for creating new zones.
- **SSL Module**: Manages SSL configurations and certificates.

Each module is self-contained and can be used independently or combined as per your infrastructure requirements.

## Usage
To use these modules, you need to define them in your Terraform configurations. Here's a basic example of how you might use a module:

```hcl
module "cloudflare_dns" {
  source = "./modules/zones_params/dns"

  # Variables for the DNS module
}

module "cloudflare_new_zones" {
  source = "./modules/new_zones"

  # Variables for the new zone module
}
