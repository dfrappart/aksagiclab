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

data "terraform_remote_state" "AKSClus1" {
  backend   = "azurerm"
  config    = {
    storage_account_name = var.statestoa
    container_name       = var.statecontainer
    key                  = var.statekeyAKSClus1State
    access_key           = var.statestoakey
  }
}


data "azurerm_resource_group" "AKSRG" {
  name                  = data.terraform_remote_state.AKSClus1.outputs.RGName
}

data "azurerm_subnet" "AKSSubnet" {
  name                  = data.terraform_remote_state.AKSClus1.outputs.FESubnetName
  virtual_network_name  = data.terraform_remote_state.AKSClus1.outputs.VNetName
  resource_group_name   = data.azurerm_resource_group.AKSRG.name
}

data "azurerm_subnet" "AGWSubnet" {
  name                  = data.terraform_remote_state.AKSClus1.outputs.AGWSubnetName
  virtual_network_name  = data.terraform_remote_state.AKSClus1.outputs.VNetName
  resource_group_name   = data.azurerm_resource_group.AKSRG.name
}

data "azurerm_kubernetes_cluster" "AKSCluster" {
  name                  = data.terraform_remote_state.AKSClus1.outputs.FullAKS.name
  resource_group_name   = data.azurerm_resource_group.AKSRG.name
}