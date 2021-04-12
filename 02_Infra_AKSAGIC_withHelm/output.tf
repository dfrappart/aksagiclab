######################################################
# Subscription Output

output "CurrentSubFullOutput" {

  value             = data.azurerm_subscription.current
}

######################################################
#Resource Group ouputs

output "RGName" {

  value             = module.ResourceGroup.RGName
}

output "RGLocation" {

  value             = module.ResourceGroup.RGLocation
}

output "RGId" {

  value             = module.ResourceGroup.RGId
  sensitive         = true
}

######################################################
# Module VNet Outputs
######################################################

##############################################################
#Output for the storage account log

output "STALogsFullOutput" {
  value             = module.AKSVNet.STALogsFullOutput
  sensitive         = true
}


##############################################################
#Output Log analytics workspace

output "LAWFullOutput" {
  value             = module.AKSVNet.LAWFullOutput
  sensitive         = true
}


##############################################################
#Output for the VNet

output "VNetFullOutput" {
  value             = module.AKSVNet.VNetFullOutput
  sensitive         = true
}

output "VNetName" {
  value             = module.AKSVNet.VNetFullOutput.name
  sensitive         = true
}

##############################################################
# Subnet outputs

# Subnet Bastion

output "AzureBastionSubnetFullOutput" {
  value             = module.AKSVNet.AzureBastionSubnetFullOutput
  sensitive         = true
}

# Subnet AppGW

output "AGWSubnetFullOutput" {
  value             = module.AKSVNet.AGWSubnetFullOutput
  sensitive         = true
}

output "AGWSubnetName" {
  value             = module.AKSVNet.AGWSubnetFullOutput.name
  sensitive         = true
}
# Subnet FESubnet

output "FESubnetFullOutput" {
  value             = module.AKSVNet.FESubnetFullOutput
  sensitive         = true
}

output "FESubnetName" {
  value             = module.AKSVNet.FESubnetFullOutput.name
  sensitive         = true
}
# Subnet BESubnet

output "BESubnetFullOutput" {
  value             = module.AKSVNet.BESubnetFullOutput
  sensitive         = true
}

##############################################################
#Outout for NSG

# NSG Bastion Subnet

output "AzureBastionNSGFullOutput" {
  value             = module.AKSVNet.AzureBastionNSGFullOutput
  sensitive         = true
}

# NSG AppGW Subnet

output "AGWSubnetNSGFullOutput" {
  value             = module.AKSVNet.AGWSubnetNSGFullOutput
  sensitive         = true
}

# NSG FE Subnet

output "FESubnetNSGFullOutput" {
  value             = module.AKSVNet.FESubnetNSGFullOutput
  sensitive         = true
}

# NSG BE Subnet

output "BESubnetNSGFullOutput" {
  value             = module.AKSVNet.BESubnetNSGFullOutput
  sensitive         = true
}

######################################################
#NSG Rules outputs

output "Default_FESubnet_AllowRDPSSHFromBastionFullOutput" {
  value             = module.AKSVNet.Default_FESubnet_AllowRDPSSHFromBastionFullOutput
  sensitive         = true
}

output "Default_FESubnet_AllowLBFullOutput" {
  value             = module.AKSVNet.Default_FESubnet_AllowLBFullOutput
  sensitive         = true
}

output "Default_FESubnet_DenyVNetSSHRDPInFullOutput" {
  value             = module.AKSVNet.Default_FESubnet_DenyVNetSSHRDPInFullOutput
  sensitive         = true
}

output "Default_BESubnet_AllowRDPSSHFromBastionFullOutput" {
  value             = module.AKSVNet.Default_BESubnet_AllowRDPSSHFromBastionFullOutput
  sensitive         = true
}

output "Default_BESubnet_AllowLBFullOutput" {
  value             = module.AKSVNet.Default_BESubnet_AllowRDPSSHFromBastionFullOutput
  sensitive         = true
}

output "Default_AppGWSubnet_GatewayManagerFullOutput" {
  value             = module.AKSVNet.Default_AppGWSubnet_GatewayManagerFullOutput
  sensitive         = true
}

output "Default_BastionSubnet_AllowHTTPSBastionInFullOutput" {
  value             = module.AKSVNet.Default_BastionSubnet_AllowHTTPSBastionInFullOutput
  sensitive         = true
}

output "Default_BastionSubnet_AllowGatewayManagerFullOutput" {
  value             = module.AKSVNet.Default_BastionSubnet_AllowGatewayManagerFullOutput
  sensitive         = true
}

output "Default_BastionSubnet_AllowRemoteBastionOutFullOutput" {
  value             = module.AKSVNet.Default_BastionSubnet_AllowRemoteBastionOutFullOutput
  sensitive         = true
}

output "Default_AllowAzureCloudHTTPSOutOutFullOutput" {
  value             = module.AKSVNet.Default_AllowAzureCloudHTTPSOutOutFullOutput
  sensitive         = true
}

output "Default_BastionSubnet_DenyVNetOutFullOutput" {
  value             = module.AKSVNet.Default_BastionSubnet_DenyVNetOutFullOutput
  sensitive         = true
}

output "Default_BastionSubnet_DenyInternetOutFullOutput" {
  value             = module.AKSVNet.Default_BastionSubnet_DenyInternetOutFullOutput
  sensitive         = true
}


##############################################################
#Output for Diagnostic logs

output "AzureBastionNSGDiagFullOutput" {
  value             = module.AKSVNet.AzureBastionNSGDiagFullOutput
  sensitive         = true
}

# NSG AppGW Subnet

output "AppGWSubnetNSGDiagFullOutput" {
  value             = module.AKSVNet.AppGWSubnetNSGDiagFullOutput
  sensitive         = true
}

# NSG FE Subnet

output "FESubnetNSGDiagFullOutput" {
  value             = module.AKSVNet.FESubnetNSGDiagFullOutput
  sensitive         = true
}


# NSG BE Subnet

output "BESubnetNSGDiagFullOutput" {
  value             = module.AKSVNet.BESubnetNSGDiagFullOutput
  sensitive         = true
}

##############################################################
#Output for Flowlogs

output "AzureBastionNSGFlowLogFullOutput" {
  value             = module.AKSVNet.AzureBastionNSGFlowLogFullOutput
  sensitive         = true
}

# NSG AppGW Subnet

output "AppGWSubnetNSGFlowLogFullOutput" {
  value             = module.AKSVNet.AppGWSubnetNSGFlowLogFullOutput
  sensitive         = true
}

# NSG FE Subnet

output "FESubnetNSGFlowLogFullOutput" {
  value             = module.AKSVNet.FESubnetNSGFlowLogFullOutput
  sensitive         = true
}

# NSG BE Subnet

output "BESubnetNSGFlowLogFullOutput" {
  value             = module.AKSVNet.BESubnetNSGFlowLogFullOutput
  sensitive         = true
}

##############################################################
#Output for Bastion Host

output "SpokeBastionFullOutput" {
  value             = module.AKSVNet.SpokeBastionFullOutput
  sensitive         = true
}



######################################################
# Output for the AKS module with RBAC enabled

output "FullAKS" {
  value             = module.AKS1.FullAKS
  sensitive         = true
}

output "AKSNodeRG" {
  value             = module.AKS1.FullAKS.node_resource_group
  sensitive         = true
}

output "KubeName" {
  value             = module.AKS1.KubeName
}

output "KubeLocation" {
  value             = module.AKS1.KubeLocation
}

output "KubeRG" {
  value             = module.AKS1.KubeRG
}

output "KubeVersion" {
  value             = module.AKS1.KubeVersion
}


output "KubeId" {
  value             = module.AKS1.KubeId
  sensitive         = true       
}


output "KubeFQDN" {
  value             = module.AKS1.KubeFQDN
}

output "KubeAdminCFGRaw" {
  value             = module.AKS1.KubeAdminCFGRaw
  sensitive         = true
}


output "KubeAdminCFG" {
  value             = module.AKS1.KubeAdminCFG
  sensitive         = true
}

output "KubeAdminCFG_UserName" {
  value             = module.AKS1.KubeAdminCFG_UserName
  sensitive         = true
}

output "KubeAdminCFG_HostName" {
  value             = module.AKS1.KubeAdminCFG_HostName
  sensitive         = true
}


output "KubeAdminCFG_Password" {
  sensitive         = true
  value             = module.AKS1.KubeAdminCFG_Password
}


output "KubeAdminCFG_ClientKey" {
  sensitive         = true
  value             = module.AKS1.KubeAdminCFG_ClientKey
}


output "KubeAdminCFG_ClientCertificate" {
  sensitive         = true
  value             = module.AKS1.KubeAdminCFG_ClientCertificate
}

output "KubeAdminCFG_ClusCACert" {
  sensitive         = true
  value             = module.AKS1.KubeAdminCFG_ClusCACert
}


output "KubeControlPlane_SAI" {
  sensitive         = true
  value             = module.AKS1.KubeControlPlane_SAI
}

output "KubeControlPlane_SAI_PrincipalId" {
  sensitive         = true
  value             = module.AKS1.KubeControlPlane_SAI_PrincipalId
}

output "KubeControlPlane_SAI_TenantId" {
  sensitive         = true
  value             = module.AKS1.KubeControlPlane_SAI_TenantId
}

output "KubeKubelet_UAI" {
  sensitive         = true
  value             = module.AKS1.KubeKubelet_UAI
}

output "KubeKubelet_UAI_ClientId" {
  sensitive         = true
  value             = module.AKS1.KubeKubelet_UAI_ClientId
}

output "KubeKubelet_UAI_ObjectId" {
  sensitive         = true
  value             = module.AKS1.KubeKubelet_UAI_ObjectId
}

output "KubeKubelet_UAI_Id" {
  sensitive         = true
  value             = module.AKS1.KubeKubelet_UAI_Id
}

output "Kube_Addons" {
  sensitive         = true
  value             = module.AKS1.FullAKS.addon_profile
}

output "Kube_AddonsOMS" {
  sensitive         = true
  value             = module.AKS1.FullAKS.addon_profile[0].oms_agent[0].oms_agent_identity[0].object_id
}


/*
######################################################################
# KV Secret module output

output "SecretTest_Id" {
  value             = module.SecretTest_to_KV.Id
  sensitive         = true 
}

output "SecretTest_Version" {
  value             = module.SecretTest_to_KV.Version
  sensitive         = true 
}

output "SecretTest_Name" {
  value             = module.SecretTest_to_KV.Name
  sensitive         = true 
}

output "SecretTest_FullOutput" {
  value             = module.SecretTest_to_KV.SecretFullOutput
  sensitive         = true 
}
*/
######################################################################
# Output for the UAI that will be used in kubernetes
######################################################################
/*

# Module Output

output "UAI1_FullUAIOutput" {
  value                 = module.UAI1.FullUAIOutput
  sensitive             = true
}
output "UAI1_Id" {
  value                 = module.UAI1.Id
  sensitive             = true
}

output "UAI1_Name" {
  value                 = module.UAI1.Name
  sensitive             = false
}

output "UAI1_Location" {
  value                 = module.UAI1.Location
  sensitive             = false
}

output "UAI1_RG" {
  value                 = module.UAI1.RG
  sensitive             = false 
}

output "UAI1_PrincipalId" {
  value                 = module.UAI1.PrincipalId
  sensitive             = true

}

output "UAI1_ClientId" {
  value                 = module.UAI1.ClientId
  sensitive             = true

}

output "UAI1_RBACAssignmentFull" {
  value           = module.UAI1.RBACAssignmentFull
  sensitive       = true
}
output "UAI1_RBACAssignmentGuid" {
  value           = module.UAI1.RBACAssignmentGuid
}

output "UAI1_RBACAssignmentScope" {
  value           = module.UAI1.RBACAssignmentScope
}

output "UAI1_RBACAssignmentRoleName" {
  value           = module.UAI1.RBACAssignmentRoleName
}

output "UAI1_RBACAssignmentPrincipalId" {
  value           = module.UAI1.RBACAssignmentPrincipalId
  sensitive       = true
}

output "UAI1_RBACAssignmentId" {
  value           = module.UAI1.RBACAssignmentId
}

output "UAI1_RBACAssignmentPrincipalType" {
  value           = module.UAI1.RBACAssignmentPrincipalType
}
*/
######################################################################
# Output yaml files for kube resources
######################################################################
/*
output "UAI1_podidentitymanifest" {
  value           = module.UAI1.podidentitymanifest
  sensitive       = true
}

output "UAI1_podidentitybindingmanifest" {
  value           = module.UAI1.podidentitybindingmanifest
  sensitive       = true
}
*/
######################################################################
# Key Vault Access Policy for UAI
/*
output "AKSKeyVaultAccessPolicy_UAI1_Id" {
  value             = module.AKSKeyVaultAccessPolicy_UAI1.Id
  sensitive         = true
}

output "AKSKeyVaultAccessPolicy_UAI1_KeyVaultId" {
  value             = module.AKSKeyVaultAccessPolicy_UAI1.KeyVaultId
  sensitive         = true
}

output "AKSKeyVaultAccessPolicy_UAI1_KeyVaultAcccessPolicyFullOutput" {
  value             = module.AKSKeyVaultAccessPolicy_UAI1.KeyVaultAcccessPolicyFullOutput
  sensitive         = true
}
*/
######################################################################
# Logic App

/*
output "LGAFull" {
  value             = module.LGA_Kured.LGAFull
  sensitive         = true
}
output "LGATrigger" {
  value             = azurerm_logic_app_trigger_http_request.example
  sensitive         = true
}

*/

######################################################################
# Application Gateway output

output "AGWFull" {
  value             = module.AGW.AppGW
  sensitive         = true
}

output "AGWId" {
  value             = module.AGW.AppGW.id
  sensitive         = true
}

output "AGWRG" {
  value             = module.AGW.AppGW.resource_group_name
  sensitive         = true
}

output "AGWName" {
  value             = module.AGW.AppGW.name
  sensitive         = true
}