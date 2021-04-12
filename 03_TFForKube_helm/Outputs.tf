##############################################################
#config output
##############################################################

output "AGICUAI" {
    value                       = module.UAIAGIC.FullUAIOutput
    sensitive                   = true
}


output "AGICUAIRole" {
    value                       = module.UAIAGIC.RBACAssignmentFull
    sensitive                   = true
}

output "agicyamlconfig" {
    value                       = data.template_file.agicyamlconfig.rendered
    sensitive                   = false

}

output "AKSSubnet" {
    value                       = data.azurerm_subnet.AKSSubnet
    sensitive                   = false

}

output "AKSSubnetRouteId" {
    value                       = data.azurerm_subnet.AKSSubnet.route_table_id
    sensitive                   = false

}