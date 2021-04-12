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

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//003_ResourceGroup/"
  #Module variable      
  RGSuffix                                = var.ResourcesSuffix
  RGLocation                              = var.AzureRegion
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  EnvironmentTag                          = var.Environment
  Project                                 = var.Project

}

module "AKSVNet" {
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules/IaaS_NTW_VNet_for_AppGW/"

  #Module variable
  RGLogName                               = data.azurerm_resource_group.RGLog.name
  LawSubLogName                           = data.azurerm_log_analytics_workspace.LAWLog.name
  STASubLogName                           = data.azurerm_storage_account.STALog.name
  TargetRG                                = module.ResourceGroup.RGName
  TargetLocation                          = module.ResourceGroup.RGLocation
  VNetSuffix                              = var.ResourcesSuffix

  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  Environment                             = var.Environment
  Project                                 = var.Project

}


######################################################################
# Module for AKS

module "AKS1" {
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules/IaaS_AKS_ClusterwithRBAC_Kubenet/"

  #Module variable
  STASubLogId                             = data.azurerm_storage_account.STALog.id
  LawSubLogId                             = data.azurerm_log_analytics_workspace.LAWLog.id

  AKSLocation                             = module.ResourceGroup.RGLocation
  AKSRGName                               = module.ResourceGroup.RGName
  AKSSubnetId                             = module.AKSVNet.FESubnetFullOutput.id
  AKSClusSuffix                           = var.AKSClusSuffix
  PublicSSHKey                            = var.AKSSSHKey
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
  source                                        = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules//232_AppGW_w_dynamicblock"
  TargetRG                                      = module.ResourceGroup.RGName
  TargetLocation                                = module.ResourceGroup.RGLocation
  LawSubLogId                                   = data.azurerm_log_analytics_workspace.LAWLog.id
  STASubLogId                                   = data.azurerm_storage_account.STALog.id
  TargetSubnetId                                = module.AKSVNet.AGWSubnetFullOutput.id
  KVId                                          = data.terraform_remote_state.Subsetupstate.outputs.AKSKeyVault_Id
  SitesConf                                     = local.SitesConf


  # Tags
  ResourceOwnerTag                              = var.ResourceOwnerTag
  CountryTag                                    = var.CountryTag
  CostCenterTag                                 = var.CostCenterTag
  Project                                       = var.Project
  Environment                                   = var.Environment

}


######################################################################
# Requirement for monitoring
######################################################################

######################################################################
# Mapping OMS UAI to Azure monitor publisher role
/*
module "AssignAKS_OMSUAI_MonitoringPublisher_To_RG" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = module.ResourceGroup.RGId
  BuiltinRoleName                         = "Monitoring Metrics Publisher"
  ObjectId                                = module.AKS1.FullAKS.addon_profile[0].oms_agent[0].oms_agent_identity[0].object_id

}
*/


######################################################################
# Requirement for Pod Identity
######################################################################

######################################################################
# Mapping AKS SAI to subscription - Managed Identity Operator

module "AssignAKS_SAI_ManagedIdentityOps_To_Sub" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = data.azurerm_subscription.current.id
  BuiltinRoleName                         = "Managed Identity Operator"
  ObjectId                                = module.AKS1.KubeControlPlane_SAI_PrincipalId

}

######################################################################
# Mapping AKS SAI to VNet

module "AssignAKS_SAI_VMContributor_To_Sub" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = data.azurerm_subscription.current.id
  BuiltinRoleName                         = "Virtual Machine Contributor"
  ObjectId                                = module.AKS1.KubeControlPlane_SAI_PrincipalId

}



######################################################################
# Mapping AKS Kubelet UAI to subscription - Managed Identity Operator

module "AssignAKS_KubeletUAI_ManagedIdentityOps_To_Sub" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = data.azurerm_subscription.current.id
  BuiltinRoleName                         = "Managed Identity Operator"
  ObjectId                                = module.AKS1.FullAKS.kubelet_identity[0].object_id
  #module.AKS1.KubeControlPlane_SAI_PrincipalId

}

######################################################################
# Mapping AKS Kubelet UAI to VM Operator role

module "AssignAKS_KubeletUAI_VMContributor_To_Sub" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = data.azurerm_subscription.current.id
  BuiltinRoleName                         = "Virtual Machine Contributor"
  ObjectId                                = module.AKS1.FullAKS.kubelet_identity[0].object_id

}





######################################################################
# Creating a RG and LGA for kured

# Creating the Resource Group

module "ResourceGroup_Kured" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//003_ResourceGroup/"
  #Module variable      
  RGSuffix                                = "${var.ResourcesSuffix}kured"
  RGLocation                              = var.AzureRegion
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  EnvironmentTag                          = var.Environment
  Project                                 = var.Project

}

module "LGA_Kured" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//700_LogicAppBasic/"
  #Module variable      
  LGASuffix                               = "${var.ResourcesSuffix}kured"
  RGName                                  = module.ResourceGroup_Kured.RGFull.name
  LGALocation                             = var.AzureRegion
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  EnvironmentTag                          = var.Environment
  Project                                 = var.Project

}

resource "azurerm_logic_app_trigger_http_request" "example" {
  name         = "some-http-trigger"
  logic_app_id = module.LGA_Kured.LGAFull.id

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



resource "null_resource" "Install_AGIC_Addon" {
  #Use this resource to install AGI on CLI
  #count = local.agicaddonstatus == "false" ? 1 : 0
  provisioner "local-exec" {
    command = "az aks enable-addons -n ${module.AKS1.FullAKS.name} -g ${module.ResourceGroup.RGName} -a ingress-appgw --appgw-id ${module.AGW.AppGW.id}"
  }

  depends_on = [
    module.AGW,
    module.AKS1,
    #null_resource.Test_AGIC_Addon
  ]
}

