# Configure the minimum required providers supported by this module
terraform {
  experiments = [module_variable_optional_attrs]
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.16.0"
      #configuration_aliases = [
      #  azurerm.connectivity,
      #  azurerm.management,
      #]
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.22.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
    null = {
      source = "hashicorp/null"
    }
  }

  required_version = "~> 1.2.4"
}

data "azurerm_client_config" "current" {}

