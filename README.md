# terraform-azurerm-arc-onprem-linux-vm

Module to create an Azure VM with the AAD extension configured.

It also includes a valid cloud_init.yaml which will install:

* azure-cli
* terraform
* jq
* stress
* tree

It also updates the skeleton bashrc with a JQ_COLORS setting to match the Azure CLI's jsonc output colour scheme.

Intended for use by the [examples](https://github.com/terraform-azurerm-examples).
