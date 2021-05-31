# Self-signed Certificates Example

This folder shows an example of [Terraform](https://www.terraform.io) code that uses the [terraform-hcloud-certificates](https://github.com/peterpramb/terraform-hcloud-certificates) module to manage self-signed certificates in the [Hetzner Cloud](https://www.hetzner.com/cloud).

:information\_source: **IMPORTANT**: This example points to the master branch of the module for simplicity. In your code, you should always pin to a specific official release.


## Quick Start

To run the example:

1. Install [Terraform](https://www.terraform.io).
2. Run `git clone` to clone this repository to your computer.
3. Run `export HCLOUD_TOKEN="<api_token>"` to prepare the environment.
4. Run `terraform init`.
5. Run `terraform apply`.
