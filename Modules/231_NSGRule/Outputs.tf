######################################################################
# This module create a keyvault resource
######################################################################


#Module Output

output "RuleId" {
  value               = azurerm_network_security_rule.NSGRule.id
}

output "RuleName" {
  value               = azurerm_network_security_rule.NSGRule.name
}

output "RulePriority" {
  value               = azurerm_network_security_rule.NSGRule.priority
}

output "RuleDirection" {
  value               = azurerm_network_security_rule.NSGRule.direction
}

output "RuleAccess" {
  value               = azurerm_network_security_rule.NSGRule.access
}

output "RuleProtocol" {
  value               = azurerm_network_security_rule.NSGRule.protocol
}

output "RuleSRCPort" {
  value               = azurerm_network_security_rule.NSGRule.source_port_range
}

output "RuleDestPort" {
  value               = azurerm_network_security_rule.NSGRule.destination_port_ranges
}

output "RuleSRCAddressPrefixes" {
  value               = azurerm_network_security_rule.NSGRule.source_address_prefix
}

output "RuleDestAddressPrefixes" {
  value               = azurerm_network_security_rule.NSGRule.destination_address_prefix
}

output "RuleTargetNSG" {
  value               = azurerm_network_security_rule.NSGRule.network_security_group_name
}