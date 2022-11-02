#----------------------------------------
# Create the log analytics workspace.
#----------------------------------------
resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-hub-${var.shortcompanyname}-01"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags = {
    "Critical"    = "Yes"
    "Solution"    = "Logs"
    "Costcenter"  = "It"
    "Environment" = "Hub"
  }
}

#-----------------------------------
# Enable VM insights LA solution
#-----------------------------------
resource "azurerm_log_analytics_solution" "vm-insights" {
  solution_name         = "VMInsights"
  location              = var.resource_group.location
  resource_group_name   = var.resource_group.name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/VMInsights"
  }
}

#------------------------------
# Enable Update LA solution
#------------------------------
resource "azurerm_log_analytics_solution" "Updates" {
  solution_name         = "Updates"
  location              = var.resource_group.location
  resource_group_name   = var.resource_group.name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/Updates"
  }
}

#--------------------------------------------
# Enabel network monitoring LA solution
#--------------------------------------------
resource "azurerm_log_analytics_solution" "network" {

  solution_name         = "NetworkMonitoring"
  location              = var.resource_group.location
  resource_group_name   = var.resource_group.name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/NetworkMonitoring"
  }
}

#--------------------------------------
# Enable security center LA solution
#--------------------------------------
resource "azurerm_log_analytics_solution" "sec-center" {

  solution_name         = "SecurityCenterFree"
  location              = var.resource_group.location
  resource_group_name   = var.resource_group.name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityCenterFree"
  }
}

#-------------------------------
# Enable security LA solution
#-------------------------------
resource "azurerm_log_analytics_solution" "Security" {
  solution_name         = "Security"
  location              = var.resource_group.location
  resource_group_name   = var.resource_group.name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/Security"
  }
}

#------------------------------------
# Enable antimalware LA solution
#------------------------------------
resource "azurerm_log_analytics_solution" "antimalware" {
  solution_name         = "AntiMalware"
  location              = var.resource_group.location
  resource_group_name   = var.resource_group.name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/AntiMalware"
  }
}

#------------------------------------------
# Enable azure automation LA solution
#------------------------------------------
resource "azurerm_log_analytics_solution" "automation" {
  solution_name         = "AzureAutomation"
  location              = var.resource_group.location
  resource_group_name   = var.resource_group.name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/AzureAutomation"
  }
}

#----------------------------------------
# Enable change tracking LA solution
#----------------------------------------
resource "azurerm_log_analytics_solution" "change-tracking" {
  solution_name         = "ChangeTracking"
  location              = var.resource_group.location
  resource_group_name   = var.resource_group.name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ChangeTracking"
  }
}

#-----------------------------------------
# Enable containerinsights LA solution
#-----------------------------------------
resource "azurerm_log_analytics_solution" "containers" {
  solution_name         = "ContainerInsights"
  location              = var.resource_group.location
  resource_group_name   = var.resource_group.name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

#-----------------------------------
# Enable servicemap LA solution
#-----------------------------------
resource "azurerm_log_analytics_solution" "servicemap" {
  solution_name         = "ServiceMap"
  location              = var.resource_group.location
  resource_group_name   = var.resource_group.name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ServiceMap"
  }
}

#-------------------------------------------
# Enable monitoring diagnostic settings
#-------------------------------------------
resource "azurerm_monitor_diagnostic_setting" "law-diag" {
  name                       = "diag-hub-${var.shortcompanyname}-law"
  target_resource_id         = azurerm_log_analytics_workspace.law.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  log {
    category = "Audit"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
    }
  }
}

#-----------------------------------------------------
# Enable SQLVulnerabilityAssessment LA solution
#-----------------------------------------------------
resource "azurerm_log_analytics_solution" "SQLVulnerabilityAssessment" {
  solution_name         = "SQLVulnerabilityAssessment"
  location              = var.resource_group.location
  resource_group_name   = var.resource_group.name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SQLVulnerabilityAssessment"
  }
}

#--------------------------------------------------------
# Enable SQLAdvancedThreatProtection LA solution
#--------------------------------------------------------
resource "azurerm_log_analytics_solution" "SQLAdvancedThreatProtection" {
  solution_name         = "SQLAdvancedThreatProtection"
  location              = var.resource_group.location
  resource_group_name   = var.resource_group.name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SQLAdvancedThreatProtection"
  }
}

#----------------------------------------
# Enable SQLAssessment LA solution
#----------------------------------------
resource "azurerm_log_analytics_solution" "SQLAssessment" {
  solution_name         = "SQLAssessment"
  location              = var.resource_group.location
  resource_group_name   = var.resource_group.name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SQLAssessment"
  }
}

#-------------------------------------
# Enable AzureActivity LA solution
#-------------------------------------
resource "azurerm_log_analytics_solution" "AzureActivity" {
  solution_name         = "AzureActivity"
  location              = var.resource_group.location
  resource_group_name   = var.resource_group.name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/AzureActivity"
  }
}