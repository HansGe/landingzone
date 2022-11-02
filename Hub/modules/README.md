# Introduction
This is the module to deploy a basic "LandingZone". We tried to make the module as customizable as possible. This because we believe a customers are not the same and should be handled as such.

This module consists out of two major parts:
- A hub where we deploy the shared components
- Landingzones which are workload landingzones

The hub will create the following components
- Azure AD connect server
- Automation account
- Azure firewall
- Backup service
- Bastion host
- Domain controllers
- Kevault
- Log analytics workspace
- Resource groups
- Storage account for boot diagnostics
- Storage account for CloudShell
- Hub VNET with the following subnets:
    - Identity subnet
    - Shared subnet
    - Privatelink subnet
    - GatewaySubnet
    - AzureFirewallSubnet
    - AzureBastionSubnet
- Virtual network gateway

The LandingZone will create following components:
- list of components

Additionally the module can create management groups.
When there are no management groups defined, default management groups will be created.

# Shared variables between hub and landingzone
variable name | description | example | optional/required | type
--- | --- | --- | --- | ---
fullcompanyname | Name of the customer for who we will deploy this. | "Proximus" | required | `string`
shortcompanyname | Short abbreviation for the customer. | "PXS" | required | `string`
location | location where the components should be deployed. Possible values are westeurope and northeurope | "westeurope" | optional, will default to "westeurope" | `string`

# Variables specific for the hub components
variable name | description | example | optional/required | type
--- | --- | --- | --- | ---
hub_vnet | A /24 cidr for the hub vnet. Only /24 will be accepted and the necessary subnets will be deployed with the minimum cidr. | "10.1.0.0/24" | required | `string`
dc | With this bool you can decide if you want to deploy domain controllers or not. The domain controller will double as DNS servers | false | optional, will default to true | `bool`
dc_size | VM size for the domain controllers. | "Standard_DS2_v2" | optional, will default to Standard_DS2_v2 | `string`
bastion | With this bool you can decide if you want to deploy a bastion host. | false | optional, will default to true | `bool`
bastion_sku | The SKU of the Bastion Host. Accepted values are Basic and Standard. Defaults to Standard. | "Basic" | optional, will default to Standard | `string`
azure_firewall | With this bool you can decide if you want to deploy an Azure firewall. | false | optional, will default to true | `bool`
fw_tier | SKU tier of the Firewall. Possible values are Premium and Standard. Defaults to Standard. | "Premium" | optional, will default to "Standard" | `string`
aadc | With this bool you can decide if you want to deploy a VM for Azure AD Connect. | false | optional, will default to true | `bool`
aadc_size | VM size for the Azure AD Connect server. | "Standard_DS2_v2" | optional, will default to Standard_DS2_v2 | `string`

# Considerations
Microsoft enabled auto enrollment for network watcher. 
- https://azure.microsoft.com/en-us/updates/azure-network-watcher-will-be-enabled-by-default-for-subscriptions-containing-virtual-networks/
- https://docs.microsoft.com/en-us/azure/network-watcher/network-watcher-create#opt-out-of-network-watcher-automatic-enablement

To opt-out we need to run the following script

- Powershell

`Register-AzProviderFeature -FeatureName DisableNetworkWatcherAutocreation -ProviderNamespace Microsoft.Network`

`Register-AzResourceProvider -ProviderNamespace Microsoft.Network`

- CLI

`az feature register --name DisableNetworkWatcherAutocreation --namespace Microsoft.Network`

`az provider register -n Microsoft.Network`