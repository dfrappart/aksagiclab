######################################################################
# This module create a NAT GW and its Public IP
######################################################################



resource "azurerm_network_security_rule" "NSGRule" {
  name                                            = "Project_${var.RuleSuffix}"
  resource_group_name                             = var.TargetRG
  network_security_group_name                     = var.TargetNSG
  description                                     = var.RuleDesc == "Undescribed" ? "Project_${var.RuleSuffix}" : var.RuleDesc
  protocol                                        = var.RuleProtocol
  direction                                       = var.RuleDirection
  priority                                        = var.RulePriority
  access                                          = var.RuleAccess

  source_port_range                               = var.RuleSRCPort
  source_port_ranges                              = var.RuleSRCPorts

  source_address_prefix                           = var.RuleSRCAddressPrefix
  source_address_prefixes                         = var.RuleSRCAddressPrefixes

  source_application_security_group_ids           = var.RuleSRCASGs

  destination_port_range                          = var.RuleDestPort
  destination_port_ranges                         = var.RuleDestPorts

  destination_address_prefix                      = var.RuleDestAddressPrefix
  destination_address_prefixes                    = var.RuleDestAddressPrefixes

  destination_application_security_group_ids      = var.RuleDestASGs

}