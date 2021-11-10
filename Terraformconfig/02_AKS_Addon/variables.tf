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
  default                         = "csi"
}

variable "Environment" {
  type                            = string
  description                     = "The environment, dev, prod..."
  default                         = "lab"
}

variable "ResourcesSuffix" {
  type                            = string
  description                     = "The environment, dev, prod..."
  default                         = "csimeetup"
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


##############################################
#Variable for using AKS state as a data source

variable "statestoa" {
  type    = string
  description = "the name of the storage account storing the state of the 02 automation setup configuration"
}

variable "statecontainer" {
  type    = string
  description = "The name of the container in which the state is stored"
}

variable "statestoakey" {
  type    = string
  description = "The storage access key of the storage account"
}

variable "statekeyAKSClusState" {
  type    = string
  description = "the name of the file containing the state of the 02 Azure Autmation setup configuration"
}