#############################################################################
#This file is used to define data source refering to Azure existing resources
#############################################################################

#############################################################################
#data sources


data "azurerm_subscription" "current" {}

data "azurerm_client_config" "currentclientconfig" {}




#############################################################################
#data source for subscription setup logs features



data "terraform_remote_state" "Subsetupstate" {
  backend                     = "azurerm"
  config                      = {
    storage_account_name      = var.SubsetupSTOAName
    container_name            = var.SubsetupContainerName
    key                       = var.SubsetupKey
    access_key                = var.SubsetupAccessKey
  }
}

#############################################################################
#data source for AKS


#Data source for remote state

data "terraform_remote_state" "AKSClus" {
  backend   = "azurerm"
  config    = {
    storage_account_name = var.statestoa
    container_name       = var.statecontainer
    key                  = var.statekeyAKSClusState
    access_key           = var.statestoakey
  }
}


data "azurerm_resource_group" "AKSRG" {
  name                  = data.terraform_remote_state.AKSClus.outputs.RG2_Name
}

data "azurerm_subnet" "AKSSubnet" {
  name                  = data.terraform_remote_state.AKSClus.outputs.FESubnet_VNet2_Name
  virtual_network_name  = data.terraform_remote_state.AKSClus.outputs.VNet2_Name
  resource_group_name   = data.azurerm_resource_group.AKSRG.name
}

data "azurerm_subnet" "AGWSubnet" {
  name                  = data.terraform_remote_state.AKSClus.outputs.AGWSubnet_VNet2_FullOutput.name
  virtual_network_name  = data.terraform_remote_state.AKSClus.outputs.VNet2_Name
  resource_group_name   = data.azurerm_resource_group.AKSRG.name
}

data "azurerm_kubernetes_cluster" "AKSCluster" {
  name                  = data.terraform_remote_state.AKSClus.outputs.FullAKS2.name
  resource_group_name   = data.azurerm_resource_group.AKSRG.name
}

data "azurerm_application_gateway" "AGW" {
  name                  = data.terraform_remote_state.AKSClus.outputs.AGW2Name
  resource_group_name   = data.azurerm_resource_group.AKSRG.name
}