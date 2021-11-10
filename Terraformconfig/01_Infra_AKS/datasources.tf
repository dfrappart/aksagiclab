#############################################################################
#This file is used to define data source refering to Azure existing resources
#############################################################################


#############################################################################
#data sources


data "azurerm_subscription" "current" {}

data "azurerm_client_config" "currentclientconfig" {}




#############################################################################
#data source for Network State



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
#Data source for the RG Log

data "azurerm_resource_group" "RGLog" {
  name                  = data.terraform_remote_state.Subsetupstate.outputs.RGLogName
}

#Data source for the log storage

data "azurerm_storage_account" "STALog" {
  name                  = data.terraform_remote_state.Subsetupstate.outputs.STALogName
  resource_group_name   = data.azurerm_resource_group.RGLog.name
}

#Data source for the log analytics workspace

data "azurerm_log_analytics_workspace" "LAWLog" {
  name                  = data.terraform_remote_state.Subsetupstate.outputs.SubLogAnalyticsName
  resource_group_name   = data.azurerm_resource_group.RGLog.name
}

#Data source for the ACG

data "azurerm_monitor_action_group" "SubACG" {
  name                  = data.terraform_remote_state.Subsetupstate.outputs.DefaultSubActionGroupName
  resource_group_name   = data.azurerm_resource_group.RGLog.name
}

#############################################################################
#data source for the keyvault AGW

data "azurerm_key_vault" "aks_agw_keyvault" {
  name                        = data.terraform_remote_state.Subsetupstate.outputs.AKSKeyVault_Name 
  resource_group_name         = data.terraform_remote_state.Subsetupstate.outputs.AKSKeyVault_RG
}


# data sourcing the cert

data "azurerm_key_vault_certificate" "AGWCertForAGICCert" {
  name                        = data.terraform_remote_state.Subsetupstate.outputs.Cert1Name
  key_vault_id                = data.terraform_remote_state.Subsetupstate.outputs.AKSKeyVault_Id
}

# also data sourcing the cert as a secret to get the secret identifier

data "azurerm_key_vault_secret" "AGWCertForAGICSecret" {
  name                        = data.terraform_remote_state.Subsetupstate.outputs.Cert1Name
  key_vault_id                = data.terraform_remote_state.Subsetupstate.outputs.AKSKeyVault_Id
}

# data sourcing the aks ssh key in the kv

data "azurerm_key_vault_secret" "AKSSSHKey" {
  name                        = data.terraform_remote_state.Subsetupstate.outputs.AKSSSHPublic_OpenSSH_To_Kv
  key_vault_id                = data.terraform_remote_state.Subsetupstate.outputs.AKSKeyVault_Id
}
