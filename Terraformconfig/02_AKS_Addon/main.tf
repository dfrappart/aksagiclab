######################################################################
# backend block for partial configuration
######################################################################

terraform {
  backend "azurerm" {}
}

######################################################################
# Access to Azure
######################################################################

provider "azurerm" {
  subscription_id                          = var.AzureSubscriptionID
  client_id                                = var.AzureClientID
  client_secret                            = var.AzureClientSecret
  tenant_id                                = var.AzureTenantID

  features {}
  
}



######################################################################
# Add on agic through az cli

resource "null_resource" "Install_AGIC_Addon" {
  #Use this resource to install AGI on CLI
  #count = local.agicaddonstatus == "false" ? 1 : 0
  provisioner "local-exec" {
    command = "az aks enable-addons -n ${data.azurerm_kubernetes_cluster.AKSCluster.name} -g ${data.azurerm_resource_group.AKSRG.name} -a ingress-appgw --appgw-id ${data.azurerm_application_gateway.AGW.id}"
  }

  depends_on = [

  ]
}

