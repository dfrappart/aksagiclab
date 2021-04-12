######################################################
# This file defines which value are sent to output
######################################################

###################################################################
# Outputs for Az subscription logging config module

###################################################################
# Outputs for RG

output "RGLogName" {

  value                   = module.BasicLogConfig.RGLogName
}

output "RGLogLocation" {

  value                   = module.BasicLogConfig.RGLogLocation
}

output "RGLogId" {

  value                   = module.BasicLogConfig.RGLogId
  sensitive               = true
}

###################################################################
#Output for the log storage account

output "STALogName" {
  value                   = module.BasicLogConfig.STALogName
}

output "STALogId" {
  value                   = module.BasicLogConfig.STALogId
  sensitive               = true
}

output "STALogPrimaryBlobEP" {
  value                   = module.BasicLogConfig.STALogPrimaryBlobEP
  sensitive               = true
}

output "STALogPrimaryQueueEP" {
  value                   = module.BasicLogConfig.STALogPrimaryQueueEP
  sensitive               = true
}

output "STALogPrimaryTableEP" {
  value                   = module.BasicLogConfig.STALogPrimaryTableEP
  sensitive               = true
}

output "STALogPrimaryFileEP" {
  value                   = module.BasicLogConfig.STALogPrimaryFileEP
  sensitive               = true
}

output "STALogPrimaryAccessKey" {
  value                   = module.BasicLogConfig.STALogPrimaryAccessKey
  sensitive               = true
}

output "STALogSecondaryAccessKey" {
  value                   = module.BasicLogConfig.STALogSecondaryAccessKey
  sensitive               = true
}

output "STALogConnectionURI" {
  value                   = module.BasicLogConfig.STALogConnectionURI
  sensitive               = true
}

###################################################################
#Output for the log analytics workspace

output "SubLogAnalyticsFull" {
  value                     = module.BasicLogConfig.SubLogAnalyticsFull
  sensitive                 = true
}

output "SubLogAnalyticsName" {
  value                     = module.BasicLogConfig.SubLogAnalyticsFull.name
  sensitive                 = true

}

##############################################################
#observability basics outputs
##############################################################

output "DeploymentType" {

  value                   = module.ObservabilityConfig.DeploymentType
}

##############################################################
#Output NetworkWatcher


output "NetworkWatcherName" {

  value                   = module.ObservabilityConfig.NetworkWatcherName

}

output "NetworkWatcherId" {

  value                   = module.ObservabilityConfig.NetworkWatcherId
  sensitive               = true
}

output "NetworkWatcherRGName" {

  value                   = module.ObservabilityConfig.NetworkWatcherRGName
}

##############################################################
#Azure Security Center Output

output "ASCTier" {

  value                   = module.ObservabilityConfig.ASCTier
}

output "ASCId" {

  value                   = module.ObservabilityConfig.ASCId
  sensitive               = true
}
/*
output "ASCContact" {

  value                   = module.ObservabilityConfig.ASCContact
}
*/
##############################################################
#Action Group Output

output "DefaultSubActionGroupId" {

  value                   = module.ObservabilityConfig.DefaultSubActionGroupId
  sensitive               = true
}

output "DefaultSubActionGroupName" {

  value                   = module.ObservabilityConfig.DefaultSubActionGroupName
}

output "DefaultSubActionGroupEmailReceiver" {

  value                   = module.ObservabilityConfig.DefaultSubActionGroupEmailReceiver
}

##############################################################
#Service health Alerts Output

output "ServiceHealthAlertName" {

  value                   = module.ObservabilityConfig.ServiceHealthAlertName
}

output "ServiceHealthAlertId" {

  value                   = module.ObservabilityConfig.ServiceHealthAlertId
  sensitive               = true

}

output "ServiceHealthAlertCriteria" {

  value                   = module.ObservabilityConfig.ServiceHealthAlertCriteria
}

##############################################################
#Resources health Alerts Output

output "ResourcesHealthAlertName" {

  value                   = module.ObservabilityConfig.ResourcesHealthAlertName
}

output "ResourcesHealthAlertId" {

  value                   = module.ObservabilityConfig.ResourcesHealthAlertId
  sensitive               = true
}

output "ResourcesHealthAlertCriteria" {

  value                   = module.ObservabilityConfig.ResourcesHealthAlertCriteria
}

output "testsubid" {
  value = data.azurerm_subscription.current.id
}

output "testsubidsubstr" {
  value = substr(data.azurerm_subscription.current.id,15,8)
}


######################################################################
# Key Vault Output

output "AKSKeyVault_FullKVOutput" {
  value             = module.AKSKeyVault.FullKVOutput
  sensitive         = true
}

output "AKSKeyVault_Id" {
  value             = module.AKSKeyVault.Id
  sensitive         = true
}

output "AKSKeyVault_Name" {
  value             = module.AKSKeyVault.Name
  sensitive         = false

}

output "AKSKeyVault_Location" {
  value             = module.AKSKeyVault.Location
  sensitive         = false

}

output "AKSKeyVault_RG" {
  value             = module.AKSKeyVault.RG
  sensitive         = false

}

output "AKSKeyVault_SKU" {
  value             = module.AKSKeyVault.SKU
  sensitive         = false
}

output "AKSKeyVault_TenantId" {
  value             = module.AKSKeyVault.TenantId
  sensitive         = true
}

output "AKSKeyVault_URI" {
  value             = module.AKSKeyVault.URI
  sensitive         = true
}


output "AKSKeyVault_KeyVault_enabled_for_disk_encryption" {
  value             = module.AKSKeyVault.KeyVault_enabled_for_disk_encryption
  sensitive         = false
}

output "AKSKeyVault_KeyVault_enabled_for_template_deployment" {
  value             = module.AKSKeyVault.KeyVault_enabled_for_template_deployment
  sensitive         = false
}

######################################################################
# Key Vault Access Policy for TF sp

output "AKSKeyVaultAccessPolicyTF_Id" {
  value             = module.AKSKeyVaultAccessPolicyTF.Id
  sensitive         = true
}

output "AKSKeyVaultAccessPolicyTF_KeyVaultId" {
  value             = module.AKSKeyVaultAccessPolicyTF.KeyVaultId
  sensitive         = true
}

output "AKSKeyVaultAccessPolicyTF_KeyVaultAcccessPolicyFullOutput" {
  value             = module.AKSKeyVaultAccessPolicyTF.KeyVaultAcccessPolicyFullOutput
  sensitive         = true
}

######################################################################
# KV access policy for aks admins

output "AKSKeyVaultAccessPolicy_ClusterAdmin_Id" {
  value             = module.AKSKeyVaultAccessPolicy_ClusterAdmin.Id
  sensitive         = true
}

output "AKSKeyVaultAccessPolicy_ClusterAdmin_KeyVaultId" {
  value             = module.AKSKeyVaultAccessPolicy_ClusterAdmin.KeyVaultId
  sensitive         = true
}

output "AKSKeyVaultAccessPolicy_ClusterAdmin_KeyVaultAcccessPolicyFullOutput" {
  value             = module.AKSKeyVaultAccessPolicy_ClusterAdmin.KeyVaultAcccessPolicyFullOutput
  sensitive         = true
}

######################################################################
# Key Vault Cert


output "CertId" {
  value               = module.AKS_AGW_Cert_Wildcard.*.Id
  sensitive           = true
}

output "CertFull" {
  value               = module.AKS_AGW_Cert_Wildcard.*.Full
  sensitive           = true
}

output "Cert1Name" {
  value               = module.AKS_AGW_Cert_Wildcard[0].Full.name
  sensitive           = true
}