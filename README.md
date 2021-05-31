[![License](https://img.shields.io/github/license/peterpramb/terraform-hcloud-certificates)](https://github.com/peterpramb/terraform-hcloud-certificates/blob/master/LICENSE)
[![Latest Release](https://img.shields.io/github/v/release/peterpramb/terraform-hcloud-certificates?sort=semver)](https://github.com/peterpramb/terraform-hcloud-certificates/releases/latest)
[![Terraform Version](https://img.shields.io/badge/terraform-%E2%89%A5%200.13.0-623ce4)](https://www.terraform.io)


# terraform-hcloud-certificates

[Terraform](https://www.terraform.io) module for managing certificates in the [Hetzner Cloud](https://www.hetzner.com/cloud), with support for deploying provider-managed certificates and importing existing certificates and private keys.

It implements the following [provider](#providers) resources:

- [hcloud\_managed\_certificate](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/managed_certificate)
- [hcloud\_uploaded\_certificate](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/uploaded_certificate)

:warning: **WARNING**: Private keys will be stored unencrypted in the [Terraform state](https://www.terraform.io/docs/state). Using imported private keys in production deployments is therefore not recommended, unless your backend supports encryption of the stored Terraform state. Instead, consider to create and distribute certificates and private keys outside of Terraform, or use only provider-managed certificates with Terraform.


## Usage

```terraform
module "certificate" {
  source       = "github.com/peterpramb/terraform-hcloud-certificates?ref=<release>"

  certificates = [
    {
      name        = "cert-man-1"
      certificate = null
      private_key = null
      domains     = [
        "example.net"
        "www.example.net"
      ]
      labels      = {
        "managed"    = "true"
        "managed_by" = "Terraform"
      }
    },
    {
      name        = "cert-imp-1"
      certificate = <<-EOT
        -----BEGIN CERTIFICATE-----
        ...
        -----END CERTIFICATE-----
        EOT
      private_key = <<-EOT
        -----BEGIN RSA PRIVATE KEY-----
        ...
        -----END RSA PRIVATE KEY-----
        EOT
      domains     = []
      labels      = {
        "managed"    = "true"
        "managed_by" = "Terraform"
      }
    }
  ]
}
```


## Requirements

| Name | Version |
|------|---------|
| [terraform](https://www.terraform.io) | &ge; 0.13 |


## Providers

| Name | Version |
|------|---------|
| [hcloud](https://registry.terraform.io/providers/hetznercloud/hcloud) | &ge; 1.26 |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| certificates | List of certificate objects to be managed. | list(map([*certificate*](#certificate))) | See [below](#defaults) | yes |


#### *certificate*

| Name | Description | Type | Required |
|------|-------------|:----:|:--------:|
| [name](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/managed_certificate#name) | Unique name of the certificate. | string | yes |
| [certificate](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/uploaded_certificate#certificate) | PEM-encoded X.509 certificate. | string | yes (import only) |
| [private\_key](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/uploaded_certificate#private_key) | PEM-encoded private key for the certificate. | string | yes (import only) |
| [domains](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/managed_certificate#domain_names) | List of domain names for which the certificate should be obtained. | list(string) | yes (manage only) |
| [labels](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/managed_certificate#labels) | Map of user-defined labels. | map(string) | no |


### Defaults

```terraform
certificates = [
  {
    name        = "certificate-1"
    certificate = null
    private_key = null
    domains     = [
      "*.example.net"
    ]
    labels      = {}
  }
]
```


## Outputs

| Name | Description |
|------|-------------|
| certificates | List of all certificate objects. |
| certificate\_ids | Map of all certificate objects indexed by ID. |
| certificate\_names | Map of all certificate objects indexed by name. |


### Defaults

```terraform
certificates = [
  {
    "certificate" = "-----BEGIN CERTIFICATE---..."
    "created" = "2021-05-31 11:42:18.494551 +0000"
    "domain_names" = [
      "*.example.net",
    ]
    "fingerprint" = "0E:1A:5D:29:7B:74:32:AF:B..."
    "id" = "274471"
    "name" = "certificate-1"
    "not_valid_after" = "2021-05-31T23:32:57Z"
    "not_valid_before" = "2021-05-31T11:32:57Z"
    "type" = "managed"
  },
]

certificate_ids = {
  "274471" = {
    "certificate" = "-----BEGIN CERTIFICATE---..."
    "created" = "2021-05-31 11:42:18.494551 +0000"
    "domain_names" = [
      "*.example.net",
    ]
    "fingerprint" = "0E:1A:5D:29:7B:74:32:AF:B..."
    "id" = "274471"
    "name" = "certificate-1"
    "not_valid_after" = "2021-05-31T23:32:57Z"
    "not_valid_before" = "2021-05-31T11:32:57Z"
    "type" = "managed"
  }
}

certificate_names = {
  "certificate-1" = {
    "certificate" = "-----BEGIN CERTIFICATE---..."
    "created" = "2021-05-31 11:42:18.494551 +0000"
    "domain_names" = [
      "*.example.net",
    ]
    "fingerprint" = "0E:1A:5D:29:7B:74:32:AF:B..."
    "id" = "274471"
    "name" = "certificate-1"
    "not_valid_after" = "2021-05-31T23:32:57Z"
    "not_valid_before" = "2021-05-31T11:32:57Z"
    "type" = "managed"
  }
}
```


## License

This module is released under the [MIT](https://github.com/peterpramb/terraform-hcloud-certificates/blob/master/LICENSE) License.
