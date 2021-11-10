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

# Creating the Resource Group

module "ResourceGroup" {
  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//003_ResourceGroup/"
  #Module variable      
  RGSuffix                                = "${var.ResourcesSuffix}${count.index+1}${element(var.ResourceGroupSuffixList,count.index)}"
  RGLocation                              = var.AzureRegion
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  EnvironmentTag                          = var.Environment
  Project                                 = var.Project

}


module "AKSVNet" {

  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules/IaaS_NTW_VNet_for_AppGW/"

  #Module variable
  RGLogName                               = data.azurerm_resource_group.RGLog.name
  LawSubLogName                           = data.azurerm_log_analytics_workspace.LAWLog.name
  STALogId                                = data.azurerm_storage_account.STALog.id
  TargetRG                                = module.ResourceGroup[count.index].RGName
  TargetLocation                          = module.ResourceGroup[count.index].RGLocation
  VNetSuffix                              = "${var.ResourcesSuffix}${count.index+1}"

  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  Environment                             = var.Environment
  Project                                 = var.Project

}


######################################################################
# Module for AKS

# UAI for AKS

module "UAI_AKS" {

  count                                   = 2
  #Module location
  source = "github.com/dfrappart/Terra-AZModuletest/Modules_building_blocks/441_UserAssignedIdentity/"
  
  #Module variable
  UAISuffix                               = "aks-${lower(var.AKSClusSuffix)}${count.index+1}"
  TargetRG                                = module.ResourceGroup[count.index].RGName

}

module "AKS" {

  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules/IaaS_AKS_ClusterwithRBAC_AzureCNI/"

  #Module variable
  STASubLogId                             = data.azurerm_storage_account.STALog.id
  LawSubLogId                             = data.azurerm_log_analytics_workspace.LAWLog.id

  AKSLocation                             = module.ResourceGroup[count.index].RGLocation
  AKSRGName                               = module.ResourceGroup[count.index].RGName
  AKSSubnetId                             = module.AKSVNet[count.index].FESubnetFullOutput.id
  AKSNetworkPlugin                        = "kubenet"
  AKSClusSuffix                           = "${var.AKSClusSuffix}${count.index+1}"
  AKSIdentityType                         = "UserAssigned"
  UAIId                                   = module.UAI_AKS[count.index].FullUAIOutput.id
  PublicSSHKey                            = data.azurerm_key_vault_secret.AKSSSHKey.value
  #IsAGICEnabled                           = true
  #AGWId                                   = module.AGW.AppGW.id
  #PrivateClusterPublicFqdn                = true
  #PrivateDNSZoneId                        = "None"   #"/subscriptions/16e85b36-5c9d-48cc-a45d-c672a4393c36/resourceGroups/rsg-dns/providers/Microsoft.Network/privateDnsZones/privatelink.westeurope.azmk8s.io"
  #IsAKSPrivate                            = var.IsAKSPrivate
  
  AutoUpgradeChannelConfig                = null
  ACG1Id                                  = data.azurerm_monitor_action_group.SubACG.id
  AKSClusterAdminsIds                     = [var.AKSClusterAdminsIds]
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  Environment                             = var.Environment
  Project                                 = var.Project

}


######################################################################
# Creating an Application Gateway

locals {

  SitesConf = {
    "Site 1" = {
      SiteIdentifier                                = data.azurerm_key_vault_certificate.AGWCertForAGICCert.name 
      AppGWSSLCertNameSite                          = data.azurerm_key_vault_certificate.AGWCertForAGICCert.name 
      AppGwPublicCertificateSecretIdentifierSite    = data.azurerm_key_vault_secret.AGWCertForAGICSecret.id
      HostnameSite                                  = "aks.teknews.cloud"
    }
  }
}


module "AGW" {
  count                                         = 2
  source                                        = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules//232_AppGW_w_dynamicblock"
  TargetRG                                      = module.ResourceGroup[count.index].RGName
  TargetLocation                                = module.ResourceGroup[count.index].RGLocation
  LawSubLogId                                   = data.azurerm_log_analytics_workspace.LAWLog.id
  STASubLogId                                   = data.azurerm_storage_account.STALog.id
  TargetSubnetId                                = module.AKSVNet[count.index].AGWSubnetFullOutput.id
  TargetSubnetAddressPrefix                     = module.AKSVNet[count.index].AGWSubnetFullOutput.address_prefixes[0]
  KVId                                          = data.terraform_remote_state.Subsetupstate.outputs.AKSKeyVault_Id
  AGWSuffix                                     = "${var.ResourcesSuffix}${count.index+1}"
  SitesConf                                     = local.SitesConf


  # Tags
  ResourceOwnerTag                              = var.ResourceOwnerTag
  CountryTag                                    = var.CountryTag
  CostCenterTag                                 = var.CostCenterTag
  Project                                       = var.Project
  Environment                                   = var.Environment

}


######################################################################
# allow https on agw

module "NSGRuleHTTPSAllow_FromInternetToAGW" {
  count                           = 2
  #Module location
  source = "../../Modules/231_NSGRule/"

  #Module variable
  RuleSuffix                      = "HTTPSAllow_FromInternetToAGW"
  RulePriority                    = 1010
  RuleDirection                   = "Inbound"
  RuleAccess                      = "Allow"
  RuleProtocol                    = "Tcp"
  RuleDestPorts                    = [80,443]
  RuleSRCAddressPrefix            = "Internet"
  RuleDestAddressPrefix           = "*"
  TargetRG                        = module.ResourceGroup[count.index].RGName
  TargetNSG                       = module.AKSVNet[count.index].AGWSubnetNSGFullOutput.name


}

######################################################################
# Requirement for Pod Identity
######################################################################

######################################################################
# Mapping AKS SAI to subscription - Managed Identity Operator

module "AssignAKS_ControlPlane_UAI_ManagedIdentityOps_To_Sub" {

  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = data.azurerm_subscription.current.id
  BuiltinRoleName                         = "Managed Identity Operator"
  ObjectId                                = module.UAI_AKS[count.index].PrincipalId

}

######################################################################
# Mapping AKS SAI to VNet

module "AssignAKS_ControlPlane_UAI_VMContributor_To_Sub" {

  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = data.azurerm_subscription.current.id
  BuiltinRoleName                         = "Virtual Machine Contributor"
  ObjectId                                = module.UAI_AKS[count.index].PrincipalId

}



######################################################################
# Mapping AKS Kubelet UAI to subscription - Managed Identity Operator

module "AssignAKS_KubeletUAI_ManagedIdentityOps_To_Sub" {

  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = data.azurerm_subscription.current.id
  BuiltinRoleName                         = "Managed Identity Operator"
  ObjectId                                = module.AKS[count.index].FullAKS.kubelet_identity[0].object_id
  #module.AKS1.KubeControlPlane_SAI_PrincipalId

}

######################################################################
# Mapping AKS Kubelet UAI to VM Operator role

module "AssignAKS_KubeletUAI_VMContributor_To_Sub" {

  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = data.azurerm_subscription.current.id
  BuiltinRoleName                         = "Virtual Machine Contributor"
  ObjectId                                = module.AKS[count.index].FullAKS.kubelet_identity[0].object_id

}





######################################################################
# Creating a RG and LGA for kured

# Creating the Resource Group

module "ResourceGroup_Kured" {

  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//003_ResourceGroup/"
  #Module variable      
  RGSuffix                                = "${var.ResourcesSuffix}kured${count.index+1}"
  RGLocation                              = var.AzureRegion
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  EnvironmentTag                          = var.Environment
  Project                                 = var.Project

}

module "LGA_Kured" {

  count                                   = 2 
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//700_LogicAppBasic/"
  #Module variable      
  LGASuffix                               = "${var.ResourcesSuffix}kured${count.index+1}"
  RGName                                  = module.ResourceGroup_Kured[count.index].RGFull.name
  LGALocation                             = var.AzureRegion
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  EnvironmentTag                          = var.Environment
  Project                                 = var.Project

}

resource "azurerm_logic_app_trigger_http_request" "testhttptriggerlga" {
  count        = 2
  name         = "testhttptriggerlga${count.index+1}"
  logic_app_id = module.LGA_Kured[count.index].LGAFull.id

  schema = <<SCHEMA
{
    "type": "object",
    "properties": {
        "Channel": {
            "type": "string"
        },
        "Text": {
            "type": "string"
        },
        "Username": {
            "type": "string"
        }
    }
}
                    
SCHEMA

}

######################################################################
# Test Logic App start stop AKS

module "LGA_StopAKS" {

  count                                   = 2 
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//700_LogicAppBasic/"
  #Module variable      
  LGASuffix                               = "${var.ResourcesSuffix}StopAKS${count.index+1}"
  RGName                                  = module.ResourceGroup_Kured[count.index].RGFull.name
  LGALocation                             = var.AzureRegion
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  EnvironmentTag                          = var.Environment
  Project                                 = var.Project

}

module "LGA_StartAKS" {

  count                                   = 2 
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//700_LogicAppBasic/"
  #Module variable      
  LGASuffix                               = "${var.ResourcesSuffix}StartAKS${count.index+1}"
  RGName                                  = module.ResourceGroup_Kured[count.index].RGFull.name
  LGALocation                             = var.AzureRegion
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  EnvironmentTag                          = var.Environment
  Project                                 = var.Project

}








