output "azfw_ip" {
  value = azurerm_firewall.fw.ip_configuration[0].private_ip_address
}