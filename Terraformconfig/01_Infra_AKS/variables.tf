##############################################################
#Variable declaration for provider

variable "AzureSubscriptionID" {
  type                          = string
  description                   = "The subscription id for the authentication in the provider"
}

variable "AzureClientID" {
  type                          = string
  description                   = "The application Id, taken from Azure AD app registration"
}


variable "AzureClientSecret" {
  type                          = string
  description                   = "The Application secret"

}

variable "AzureTenantID" {
  type                          = string
  description                   = "The Azure AD tenant ID"
}

######################################################
# Common variables

variable "AzureRegion" {
  type                            = string
  description                     = "The Azure region for deployment"
  default                         = "westeurope"
}

variable "ResourceOwnerTag" {
  type                            = string
  description                     = "Tag describing the owner"
  default                         = "That would be me"
}

variable "CountryTag" {
  type                            = string
  description                     = "Tag describing the Country"
  default                         = "fr"
}

variable "CostCenterTag" {
  type                            = string
  description                     = "Tag describing the Cost Center"
  default                         = "labaks"
}

variable "Project" {
  type                            = string
  description                     = "The name of the project"
  default                         = "aks"
}

variable "Environment" {
  type                            = string
  description                     = "The environment, dev, prod..."
  default                         = "lab"
}

variable "ResourcesSuffix" {
  type                            = string
  description                     = "A suffix to add globallyon the resources"
  default                         = "meetup"
}

variable "ResourceGroupSuffixList" {
  type                            = list(string)
  description                     = "A list of potential suffix, gfor the case we could havemore than one RG"
  default                         = [""]
}

variable "UAISuffix" {
  type                            = string
  description                     = "The environment, dev, prod..."
  default                         = "lab1"
}

variable "AKSClusSuffix" {
  type                          = string
  default                       = ""
  description                   = "A suffix to identify the cluster without breacking the naming convention"

}

######################################################
# Data sources variables

variable "SubsetupSTOAName" {
  type          = string
  description   = "Name of the storage account containing the remote state"
}

variable "SubsetupAccessKey" {
  type          = string
  description   = "Access Key of the storage account containing the remote state"
}

variable "SubsetupContainerName" {
  type          = string
  description   = "Name of the container in the storage account containing the remote state"
}

variable "SubsetupKey" {
  type          = string
  description   = "State key"
}

######################################################
# AKS variables

variable "AKSClusterAdminsIds" {
  type                          = string
  description                   = " A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
}

######################################################
# AKS KV Access policy variables

variable "Secretperms_AKSClusterAdmins_AccessPolicy" {
  type                            = list
  description                     = "The authorization on the secret for the Access policy"
  default                         = ["backup","purge","recover","restore","get","list","set","delete"]

}

variable "Certperms_AKSClusterAdmins_AccessPolicy" {
  type                            = list
  description                     = "The authorization on the secret for the Access policy"
  default                         = ["backup","deleteissuers","get","getissuers","listissuers","managecontacts","manageissuers","purge","recover","restore","setissuers","list","update", "create", "import", "delete"]

}

variable "Secretperms_UAI_AKS_CSI_AccessPolicy" {
  type                            = list
  description                     = "The authorization on the secret for the Access policy"
  default                         = ["get","list"]

}

variable "KeyVaultSecretSuffix" {
  type                            = string
  description                     = "The kv secret suffix"
  default                         = "test1"

}


