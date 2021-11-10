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
# Module call
######################################################################

###############################################################
#Module creating the storage and log analytics for log

module "BasicLogConfig" {

  #Module Location
  source = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules/00_AzSubLogs/"

  #Module variable

  ResourceOwnerTag      = var.ResourceOwnerTag
  CountryTag            = var.CountryTag
  CostCenterTag         = var.CostCenterTag
  Project               = var.Project
  Environment           = var.Environment
  Company               = var.Company
  SubId                 = data.azurerm_subscription.current.subscription_id

}


###############################################################
#Module to create Observability

module "ObservabilityConfig" {

  #Module Location
  source = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules/01_ObservabilityBasics/"

  #Module variable
  ASCPricingTier                      = var.ASCPricingTier
  ASCContactMail                      = var.ASCContactMail
  Subid                               = data.azurerm_subscription.current.id
  LawId                               = module.BasicLogConfig.SubLogAnalyticsWSId
  RGLogs                              = module.BasicLogConfig.RGLogName
  SubContactList                      = var.SubContactList
  IsDeploymentTypeGreenField          = var.IsDeploymentTypeGreenField
  #Tags related resources
  Environment                         = var.Environment
  Project                             = var.Project
  CostCenterTag                       = var.CostCenterTag
  CountryTag                          = var.CountryTag
  ResourceOwnerTag                    = var.ResourceOwnerTag

 
}

# Creating the Resource Group for kv

module "ResourceGroup" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//003_ResourceGroup/"
  #Module variable      
  RGSuffix                                = var.KVSuffix
  RGLocation                              = var.AzureRegion
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  EnvironmentTag                          = var.Environment
  Project                                 = var.Project

}

######################################################################
# Module kv

# Defining a local for kv name and management with sbx

locals {
  KVSuffix = var.Environment != "lab" ? var.KVSuffix : formatdate("MMMDD",timestamp()) #module.kvrandomsuffix.Result
}

module "AKSKeyVault" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/410_Keyvault/"

  #Module variable     
  TargetRG                                = module.ResourceGroup.RGName
  TargetLocation                          = module.ResourceGroup.RGLocation
  KeyVaultTenantID                        = data.azurerm_subscription.current.tenant_id
  STASubLogId                             = module.BasicLogConfig.STALogId
  LawSubLogId                             = module.BasicLogConfig.SubLogAnalyticsWSId
  KeyVaultSuffix                          = local.KVSuffix
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  Environment                             = var.Environment
  Project                                 = var.Project


}

######################################################################
# Module access policy to give access to tf sp

module "AKSKeyVaultAccessPolicyTF" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/411_KeyVault_Access_Policy/"

  #Module variable     
  VaultId                                 = module.AKSKeyVault.Id
  KeyVaultTenantId                        = data.azurerm_subscription.current.tenant_id
  KeyVaultAPObjectId                      = data.azurerm_client_config.currentclientconfig.object_id
  Secretperms                             = var.Secretperms_TFApp_AccessPolicy
  Certperms                               = var.Certperms_TFApp_AccessPolicy

  depends_on = [
    module.AKSKeyVault,
  ]

}


######################################################################
# Access policy for AKS Addmin

module "AKSKeyVaultAccessPolicy_ClusterAdmin" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/411_KeyVault_Access_Policy/"

  #Module variable     
  VaultId                                 = module.AKSKeyVault.Id
  KeyVaultTenantId                        = data.azurerm_subscription.current.tenant_id
  KeyVaultAPObjectId                      = var.AKSClusterAdminsIds
  Secretperms                             = var.Secretperms_AKSClusterAdmins_AccessPolicy
  Certperms                               = var.Certperms_AKSClusterAdmins_AccessPolicy


}


######################################################################
# Creating wild card cert for agw

module "AKS_AGW_Cert_Wildcard" {

  count                                   = length(var.CertName_Wildcard)
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//413_KeyvaultCert/"

  #Module variable     
  KeyVaultCertName                        = var.CertName_Wildcard[count.index]
  KeyVaultId                              = module.AKSKeyVault.Id
  CertSubject                             = var.CertSubject_Wildcard[count.index]
  DNSNames                                = [var.DNSNames_Wildcard[count.index]]

  depends_on = [
    module.AKSKeyVault,
    module.AKSKeyVaultAccessPolicyTF
  ]

}


######################################################################
# Creating a private key for AKS later

resource "tls_private_key" "AKSSSHKey" {
  algorithm   = "RSA"
  #rsa_bits = 4096
}

module "AKSSSHPubKey_to_KV" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest/Modules_building_blocks/412_KeyvaultSecret/"

  #Module variable     
  KeyVaultSecretSuffix                    = "AKSSSHPub"
  PasswordValue                           = resource.tls_private_key.AKSSSHKey.public_key_openssh
  KeyVaultId                              = module.AKSKeyVault.Id
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  Environment                             = var.Environment
  Project                                 = var.Project

  depends_on = [
    module.AKSKeyVault
  ]

}

module "AKSSSHPrivKey_to_KV" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest/Modules_building_blocks/412_KeyvaultSecret/"

  #Module variable     
  KeyVaultSecretSuffix                    = "AKSSSHPriv"
  PasswordValue                           = resource.tls_private_key.AKSSSHKey.private_key_pem 
  KeyVaultId                              = module.AKSKeyVault.Id
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  Environment                             = var.Environment
  Project                                 = var.Project

  depends_on = [
    module.AKSKeyVault
  ]

}