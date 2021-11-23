######################################################################
# This module create a keyvault resource
######################################################################




######################################################
# Resource description 

variable "RuleSuffix" {
  type                      = string
  description               = "A string to specify the suffix of the rule name"
}

variable "TargetRG" {
  type                      = string
  description               = "The name of the resource group in which to create the Network Security Rule. Changing this forces a new resource to be created." 
}

variable "TargetNSG" {
  type                      = string
  description               = "The name of the Network Security Group that we want to attach the rule to. Changing this forces a new resource to be created."
}

######################################################
# Rule description 

variable "RuleProtocol" {
  type                      = string
  description               = "Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, or * (which matches all)."

}

variable "RuleDirection" {
  type                      = string
  description               = "The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound."

}

variable "RulePriority" {
  type                      = string
  description               = "Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule."

}

variable "RuleAccess" {
  type                      = string
  description               = "Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny."

}

variable "RuleDesc" {
  type                      = string
  description               = "A description for this rule. Restricted to 140 characters."
  default                   = "Undescribed"
}

######################################################
# Rule source port 

variable "RuleSRCPort" {
  type                      = string
  description               = "Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified."
  default                   = "*"

}

variable "RuleSRCPorts" {
  type                      = list
  description               = "List of source ports or port ranges. This is required if source_port_range is not specified."
  default                   = null

}

######################################################
# Rule source address prefixes 

variable "RuleSRCAddressPrefix" {
  type                      = string
  description               = "CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified."
  default                   = null
}

variable "RuleSRCAddressPrefixes" {
  type                      = list
  description               = "List of source address prefixes. Tags may not be used. This is required if source_address_prefix is not specified."
  default                   = null
}

variable "RuleSRCASGs" {
  type                      = list
  description               = "A List of source Application Security Group ID's"
  default                   = null
}

######################################################
# Rule Dest port 

variable "RuleDestPort" {
  type                      = string
  description               = "Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified."
  default                   = null
}

variable "RuleDestPorts" {
  type                      = list
  description               = "List of destination ports or port ranges. This is required if destination_port_range is not specified."
  default                   = null 
}

######################################################
# Rule source address prefixes 

variable "RuleDestAddressPrefix" {
  type                      = string
  description               = "CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. Besides, it also supports all available Service Tags like ‘Sql.WestEurope‘, ‘Storage.EastUS‘, etc. You can list the available service tags with the cli: shell az network list-service-tags --location westcentralus. For further information please see Azure CLI - az network list-service-tags. This is required if destination_address_prefixes is not specified."
  default                   = null
}

variable "RuleDestAddressPrefixes" {
  type                      = list
  description               = "List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified."
  default                   = null 
}

variable "RuleDestASGs" {
  type                      = list
  description               = "A List of destination Application Security Group ID's"
  default                   = null
}
