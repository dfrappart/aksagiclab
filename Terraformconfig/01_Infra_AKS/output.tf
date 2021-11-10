######################################################
# Subscription Output

output "CurrentSubFullOutput" {

  value             = data.azurerm_subscription.current
}

######################################################
#Resource Group ouputs

output "RG1_Name" {

  value             = module.ResourceGroup[0].RGName
}

output "RG1_Location" {

  value             = module.ResourceGroup[0].RGLocation
}

output "RG1_Id" {

  value             = module.ResourceGroup[0].RGId
  sensitive         = true
}


output "RG2_Name" {

  value             = module.ResourceGroup[1].RGName
}

output "RG2_Location" {

  value             = module.ResourceGroup[1].RGLocation
}

output "RG2_Id" {

  value             = module.ResourceGroup[1].RGId
  sensitive         = true
}

######################################################
# Module VNet Outputs
######################################################

##############################################################
#Output for the VNet

output "VNet1_FullOutput" {
  value             = module.AKSVNet[0].VNetFullOutput
  sensitive         = true
}

output "VNet1_Name" {
  value             = module.AKSVNet[0].VNetFullOutput.name
  sensitive         = true
}

output "VNet2_FullOutput" {
  value             = module.AKSVNet[1].VNetFullOutput
  sensitive         = true
}

output "VNet2_Name" {
  value             = module.AKSVNet[1].VNetFullOutput.name
  sensitive         = true
}
##############################################################
# Subnet outputs

# Subnet Bastion

output "AzureBastionSubnet_VNet1_FullOutput" {
  value             = module.AKSVNet[0].AzureBastionSubnetFullOutput
  sensitive         = true
}

output "AzureBastionSubnet_VNet2_FullOutput" {
  value             = module.AKSVNet[1].AzureBastionSubnetFullOutput
  sensitive         = true
}
# Subnet AppGW

output "AGWSubnet_VNet1_FullOutput" {
  value             = module.AKSVNet[0].AGWSubnetFullOutput
  sensitive         = true
}

output "AGWSubnet_VNet2_FullOutput" {
  value             = module.AKSVNet[1].AGWSubnetFullOutput
  sensitive         = true
}
# Subnet FESubnet

output "FESubnet_VNet1_FullOutput" {
  value             = module.AKSVNet[0].FESubnetFullOutput
  sensitive         = true
}

output "FESubnet_VNet2_FullOutput" {
  value             = module.AKSVNet[1].FESubnetFullOutput
  sensitive         = true
}

output "FESubnet_VNet1_Name" {
  value             = module.AKSVNet[0].FESubnetFullOutput.name
  sensitive         = true
}

output "FESubnet_VNet2_Name" {
  value             = module.AKSVNet[1].FESubnetFullOutput.name
  sensitive         = true
}
# Subnet BESubnet

output "BESubnetFull_VNet1_Output" {
  value             = module.AKSVNet[0].BESubnetFullOutput
  sensitive         = true
}

output "BESubnetFull_VNet2_Output" {
  value             = module.AKSVNet[1].BESubnetFullOutput
  sensitive         = true
}

##############################################################
#Outout for NSG

# NSG Bastion Subnet

output "AzureBastionNSG_VNet1_FullOutput" {
  value             = module.AKSVNet[0].AzureBastionNSGFullOutput
  sensitive         = true
}

output "AzureBastionNSG_VNet2_FullOutput" {
  value             = module.AKSVNet[1].AzureBastionNSGFullOutput
  sensitive         = true
}

# NSG AppGW Subnet

output "AGWSubnetNSG_VNet1_FullOutput" {
  value             = module.AKSVNet[0].AGWSubnetNSGFullOutput
  sensitive         = true
}

output "AGWSubnetNSG_VNet2_FullOutput" {
  value             = module.AKSVNet[1].AGWSubnetNSGFullOutput
  sensitive         = true
}

# NSG FE Subnet

output "FESubnetNSG_VNet1_FullOutput" {
  value             = module.AKSVNet[0].FESubnetNSGFullOutput
  sensitive         = true
}

output "FESubnetNSG_VNet2_FullOutput" {
  value             = module.AKSVNet[1].FESubnetNSGFullOutput
  sensitive         = true
}

# NSG BE Subnet

output "BESubnetNSG_VNet1_FullOutput" {
  value             = module.AKSVNet[0].BESubnetNSGFullOutput
  sensitive         = true
}

output "BESubnetNSG_VNet2_FullOutput" {
  value             = module.AKSVNet[1].BESubnetNSGFullOutput
  sensitive         = true
}


##############################################################
#Output for Bastion Host

output "SpokeBastion_VNET1_FullOutput" {
  value             = module.AKSVNet[0].SpokeBastionFullOutput
  sensitive         = true
}

output "SpokeBastion_VNET2_FullOutput" {
  value             = module.AKSVNet[1].SpokeBastionFullOutput
  sensitive         = true
}

######################################################
# Output for the AKS module with RBAC enabled

output "FullAKS1" {
  value             = module.AKS[0].FullAKS
  sensitive         = true
}


output "AKS1NodeRG" {
  value             = module.AKS[0].FullAKS.node_resource_group
  sensitive         = true
}

output "Kube1Name" {
  value             = module.AKS[0].KubeName
}

output "Kube1Location" {
  value             = module.AKS[0].KubeLocation
}

output "Kube1RG" {
  value             = module.AKS[0].KubeRG
}

output "Kube1Version" {
  value             = module.AKS[0].KubeVersion
}


output "Kube1Id" {
  value             = module.AKS[0].KubeId
  sensitive         = true       
}


output "Kube1FQDN" {
  value             = module.AKS[0].KubeFQDN
}

output "Kube1AdminCFGRaw" {
  value             = module.AKS[0].KubeAdminCFGRaw
  sensitive         = true
}


output "Kube1AdminCFG" {
  value             = module.AKS[0].KubeAdminCFG
  sensitive         = true
}

output "Kube1AdminCFG_UserName" {
  value             = module.AKS[0].KubeAdminCFG_UserName
  sensitive         = true
}

output "Kube1AdminCFG_HostName" {
  value             = module.AKS[0].KubeAdminCFG_HostName
  sensitive         = true
}


output "Kube1AdminCFG_Password" {
  sensitive         = true
  value             = module.AKS[0].KubeAdminCFG_Password
}


output "Kube1AdminCFG_ClientKey" {
  sensitive         = true
  value             = module.AKS[0].KubeAdminCFG_ClientKey
}


output "Kube1AdminCFG_ClientCertificate" {
  sensitive         = true
  value             = module.AKS[0].KubeAdminCFG_ClientCertificate
}

output "Kube1AdminCFG_ClusCACert" {
  sensitive         = true
  value             = module.AKS[0].KubeAdminCFG_ClusCACert
}


output "Kube1ControlPlane_SAI" {
  sensitive         = true
  value             = module.AKS[0].KubeControlPlane_SAI
}

output "Kube1ControlPlane_SAI_PrincipalId" {
  sensitive         = true
  value             = module.AKS[0].KubeControlPlane_SAI_PrincipalId
}

output "Kube1ControlPlane_SAI_TenantId" {
  sensitive         = true
  value             = module.AKS[0].KubeControlPlane_SAI_TenantId
}

output "Kube1Kubelet_UAI" {
  sensitive         = true
  value             = module.AKS[0].KubeKubelet_UAI
}

output "Kube1Kubelet_UAI_ClientId" {
  sensitive         = true
  value             = module.AKS[0].KubeKubelet_UAI_ClientId
}

output "Kube1Kubelet_UAI_ObjectId" {
  sensitive         = true
  value             = module.AKS[0].KubeKubelet_UAI_ObjectId
}

output "Kube1Kubelet_UAI_Id" {
  sensitive         = true
  value             = module.AKS[0].KubeKubelet_UAI_Id
}

output "Kube1_Addons" {
  sensitive         = true
  value             = module.AKS[0].FullAKS.addon_profile
}

output "Kube1_AddonsOMS" {
  sensitive         = true
  value             = module.AKS[0].FullAKS.addon_profile[0].oms_agent[0].oms_agent_identity[0].object_id
}

output "FullAKS2" {
  value             = module.AKS[1].FullAKS
  sensitive         = true
}


output "AKS2NodeRG" {
  value             = module.AKS[1].FullAKS.node_resource_group
  sensitive         = true
}

output "Kube2Name" {
  value             = module.AKS[1].KubeName
}

output "Kube2Location" {
  value             = module.AKS[1].KubeLocation
}

output "Kube2RG" {
  value             = module.AKS[1].KubeRG
}

output "Kube2Version" {
  value             = module.AKS[1].KubeVersion
}


output "Kube2Id" {
  value             = module.AKS[1].KubeId
  sensitive         = true       
}


output "Kube2FQDN" {
  value             = module.AKS[1].KubeFQDN
}

output "Kube2AdminCFGRaw" {
  value             = module.AKS[1].KubeAdminCFGRaw
  sensitive         = true
}


output "Kube2AdminCFG" {
  value             = module.AKS[1].KubeAdminCFG
  sensitive         = true
}

output "Kube2AdminCFG_UserName" {
  value             = module.AKS[1].KubeAdminCFG_UserName
  sensitive         = true
}

output "Kube2AdminCFG_HostName" {
  value             = module.AKS[1].KubeAdminCFG_HostName
  sensitive         = true
}


output "Kube2AdminCFG_Password" {
  sensitive         = true
  value             = module.AKS[1].KubeAdminCFG_Password
}


output "Kube2AdminCFG_ClientKey" {
  sensitive         = true
  value             = module.AKS[1].KubeAdminCFG_ClientKey
}


output "Kube2AdminCFG_ClientCertificate" {
  sensitive         = true
  value             = module.AKS[1].KubeAdminCFG_ClientCertificate
}

output "Kube2AdminCFG_ClusCACert" {
  sensitive         = true
  value             = module.AKS[1].KubeAdminCFG_ClusCACert
}


output "Kube2ControlPlane_SAI" {
  sensitive         = true
  value             = module.AKS[1].KubeControlPlane_SAI
}

output "Kube2ControlPlane_SAI_PrincipalId" {
  sensitive         = true
  value             = module.AKS[1].KubeControlPlane_SAI_PrincipalId
}

output "Kube2ControlPlane_SAI_TenantId" {
  sensitive         = true
  value             = module.AKS[1].KubeControlPlane_SAI_TenantId
}

output "Kube2Kubelet_UAI" {
  sensitive         = true
  value             = module.AKS[1].KubeKubelet_UAI
}

output "Kube2Kubelet_UAI_ClientId" {
  sensitive         = true
  value             = module.AKS[1].KubeKubelet_UAI_ClientId
}

output "Kube2Kubelet_UAI_ObjectId" {
  sensitive         = true
  value             = module.AKS[1].KubeKubelet_UAI_ObjectId
}

output "Kube2Kubelet_UAI_Id" {
  sensitive         = true
  value             = module.AKS[1].KubeKubelet_UAI_Id
}

output "Kube2_Addons" {
  sensitive         = true
  value             = module.AKS[1].FullAKS.addon_profile
}

output "Kube2_AddonsOMS" {
  sensitive         = true
  value             = module.AKS[1].FullAKS.addon_profile[0].oms_agent[0].oms_agent_identity[0].object_id
}


######################################################################
# Application Gateway output

output "AGW1Full" {
  value             = module.AGW[0].AppGW
  sensitive         = true
}

output "AGW1Id" {
  value             = module.AGW[0].AppGW.id
  sensitive         = true
}

output "AGW1RG" {
  value             = module.AGW[0].AppGW.resource_group_name
  sensitive         = true
}

output "AGW1Name" {
  value             = module.AGW[0].AppGW.name
  sensitive         = true
}

output "AGW2Full" {
  value             = module.AGW[1].AppGW
  sensitive         = true
}

output "AGW2Id" {
  value             = module.AGW[1].AppGW.id
  sensitive         = true
}

output "AGW2RG" {
  value             = module.AGW[1].AppGW.resource_group_name
  sensitive         = true
}

output "AGW2Name" {
  value             = module.AGW[1].AppGW.name
  sensitive         = true
}




