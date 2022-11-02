provider "azurerm" {
  features {
  }
  subscription_id = var.subscription
}
provider "azurerm" {
  features {}
  alias = "hub"
  subscription_id = var.hub_subscription
}
resource "azurerm_network_watcher" "hub-lz" {
  for_each = var.spoke

  name                = "nw-${var.environment}-${var.shortcompanyname}-${local.lz_location}-01"
  resource_group_name = module.std_resource_group_lz.rg["networkwatcher"].name
  location            = var.location
}

module "std_resource_group_lz" {
  source = "./modules/resource_groups"
  
  shortcompanyname = var.shortcompanyname
  rg_list          = var.std_rg_list_lz
  rg_list_nolock   = var.std_rg_list_nolock_lz

  environment = var.environment
  location    = var.location
}

module "resource_group_lz" {
    source = "./modules/resource_groups"

    count = var.rg_list == [""] ? 0 : 1

  shortcompanyname = var.shortcompanyname
  rg_list          = var.rg_list
  rg_list_nolock   = var.rg_list_nolock

  environment = var.environment
  location    = var.location
}

module "vnet" {
  source = "./modules/virtual_network"

  for_each = var.spoke

  depends_on = [
    azurerm_network_watcher.hub-lz
  ]

  hub_rg = var.hub_rg
  hub_vnet = var.hub_vnet_name
  hub_subscription = var.hub_subscription

  firewall_ip = var.firewall_ip

  resource_group = module.std_resource_group_lz.rg["networking"]

  log_analytics_id = var.log_analytics_id

  name = each.value.vnet_name
  address_space = each.value.address_space

  dns_servers = var.dns == [""] ? ["168.63.129.16"] : concat(var.dns, ["168.63.129.16"])

  subnets = each.value.subnets
}

resource "azurerm_virtual_network_peering" "hub-vnet" {
  provider = azurerm.hub
  for_each = var.spoke
  name = "peer-${var.hub_vnet_name.name}-${each.value.vnet_name}" 
  resource_group_name = var.hub_rg.name
  virtual_network_name = var.hub_vnet_name.name
  remote_virtual_network_id = "/subscriptions/${var.subscription}/resourceGroups/${module.std_resource_group_lz.rg["networking"].name}/providers/Microsoft.Network/virtualNetworks/${each.value.vnet_name}"
}