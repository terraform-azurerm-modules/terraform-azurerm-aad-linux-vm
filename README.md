# terraform-azurerm-arc-onprem-linux-vm

Module to create an Azure VM without an Azure Agent and with the IMDS endpoint blocked.

These modification allow the VM to be onboarded to Azure as an Azure Arc-enabled Server using the azcmagent.

Most variables are self explanatory, and prepare the VM for manual or scale onboarding.

For a more automated onboarding, use the following:

| var | type | description |
|---|---|---|
|azcmagent | bool | Set to true to download and install the azcmagent binary. |
|arc | object | Create a service principal with . Add required onboarding details - including the target resource group - to the arc object to automatically onboard. |

Example:

```hcl
azcmagent = true

arc = {
    tenant_id                = "tenant"
    service_principal_appid  = "appId"
    service_principal_secret = "password"

    subscription_id     = "subscriptionId"
    resource_group_name = "arc_poc"
    location            = "uksouth"

    tags = {
      platform   = "vSphere"
      datacentre = "Citadel"
      location   = "Reading"
    }
  }
```

The resource group needs to pre-exist. The service principal requires the Azure Connected Machine Onboarding role on the resource group.

See <https://github.com/terraform-azurerm-examples/arc-onprem-servers> for a fuller example.
