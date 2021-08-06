######################################################
# Variables
######################################################

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


variable "IsDeploymentTypeGreenField" {
  type                        = string
  default                     = true
  description                 = "Describe the type of deployment, can be GreenField or not. If GreenField, means that the subscription setup is not applied on a newly created subscription."


}


###################################################################
#variable declaration az log config

variable "RGLogLocation" {
  type                          = string
  description                   = "Variable defining the region for the log resources"
  default                       = "westeurope"
}

variable "SubLogSuffix" {
  type                          = string
  description                   = "Suffix to add to the resources, by default, log"
  default                       = "log"
}

###################################################################
#variable declaration kv

variable "KVSuffix" {
  type                            = string
  description                     = "The environment, dev, prod..."
  default                         = "agickv"
}

######################################################
# AKS KV Access policy variables

variable "Secretperms_TFApp_AccessPolicy" {
  type                            = list
  description                     = "The authorization on the secret for the Access policy"
  default                         = ["backup","purge","recover","restore","get","list","set","delete"]

}

variable "Certperms_TFApp_AccessPolicy" {
  type                            = list
  description                     = "The authorization on the secret for the Access policy"
  default                         = ["backup","deleteissuers","get","getissuers","listissuers","managecontacts","manageissuers","purge","recover","restore","setissuers","list","update", "create", "import", "delete"]

}

variable "Secretperms_AKSClusterAdmins_AccessPolicy" {
  type                            = list
  description                     = "The authorization on the secret for the Access policy to grant to AKS Admins"
  default                         = ["backup","purge","recover","restore","get","list","set","delete"]

}

variable "Certperms_AKSClusterAdmins_AccessPolicy" {
  type                            = list
  description                     = "The authorization on the secret for the Access policy to grant to AKS Admins"
  default                         = ["backup","deleteissuers","get","getissuers","listissuers","managecontacts","manageissuers","purge","recover","restore","setissuers","list","update", "create", "import", "delete"]

}

variable "AKSClusterAdminsIds" {
  type                          = string
  description                   = " A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
}

######################################################
# KV variables for Cert

variable "CertName_Wildcard" {
  type                            = list
  description                     = "The certificate name as it appears in the keyvault"
  default                         = [
                                      "self-signed-aks-teknews-cloud",
                                      "self-signed-lab-tek-news-cloud"
                                    ]

}

variable "CertSubject_Wildcard" {
  type                            = list
  description                     = "The certificate subject name"
  default                         = [
                                      "CN=*.aks.teknews.cloud",
                                      "CN=*.lab.teknews.cloud"
                                    ]

}

variable "DNSNames_Wildcard" {
  type                            = list
  description                     = "The DNS name associated to the certificate"
  default                         = [
                                      "*.aks.teknews.cloud",
                                      "*.lab.teknews.cloud"                                  
                                    ]

}

###################################################################
#common variables

variable "AzureRegion" {
  type                            = string
  description                     = "The Azure region for deployment"
  default                         = "westeurope"
}


variable "ResourceOwnerTag" {
  type                          = string
  description                   = "Tag describing the owner"
  default                       = "CloudTeam"
}

variable "CountryTag" {
  type                          = string
  description                   = "Tag describing the Country"
  default                       = "fr"
}

variable "CostCenterTag" {
  type                          = string
  description                   = "Tag describing the Cost Center"
  default                       = "subsetup"
}


variable "Company" {
  type                          = string
  description                   = "The Company owner of the resources"
  default                       = "df"
}

variable "Project" {
  type                          = string
  description                   = "The name of the project"
  default                       = "subsetupagic"
}

variable "Environment" {
  type                          = string
  description                   = "The environment, dev, prod..."
  default                       = "lab"
}




##############################################################
#Variable Observability basics

variable "ASCPricingTier" {
  type          = string
  description   = "The Azure Security Center Pricing Tiers, can be Free or Standard"
  default       = "Free"
}


variable "ASCContactMail" {
  type          = string
  description   = "The Azure Security Center Pricing Tiers, can be Free or Standard"

}

variable "notifySecContact" {
  type          = string
  description   = "Are the Security Contact notified by ASC ? Defualt to True"
  default       = true
}

variable "notifySubAdmins" {
  type          = string
  description   = "Are the Subscription Admins notified by ASC ? Defualt to True"
  default       = true
}

variable "SubContactList" {
  type          = string
  description   = "The contactlist email address for the alerting"


}