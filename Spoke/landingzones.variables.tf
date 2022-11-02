variable "spoke" {
  type = map(object({
    vnet_name = string
    address_space = list(string)
    subnets = map(object({
      name = string
      address_prefix = list(string)
      nsg = bool
      default_route = bool
    }))
  }))
}

variable "hub_rg" {}

variable "hub_vnet_name" {}

variable "hub_subscription" {}

variable "firewall_ip" {}

variable "log_analytics_id" {}

variable "dns" {
  type = list(string)
  default = [""]
}

variable "shortcompanyname" {}

variable "subscription" {}

variable "environment" {}

variable "location" {}

variable "rg_list" {
  type = list(string)
  default = [ "" ]
}

variable "rg_list_nolock" {
  type = list(string)
  default = [ "" ]
}

variable "std_rg_list_lz" {
  type = list(string)
  default = [
    "migration",
    "dc",
    "aadc",
    "bastion",
    "management",
    "shared",
    "networkwatcher",
    "networking",
  ]
}
variable "std_rg_list_nolock_lz" {
  type = list(string)
  default = [
    "backup",
    "backup-irp",
    "storage",
  ]
}
