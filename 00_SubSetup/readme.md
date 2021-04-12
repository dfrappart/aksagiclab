# Azure Automation setup


## Terraform provider configuration


The terraform provider is configured as follow:

```hcl.js

provider "azurerm" {
  subscription_id = var.AzureSubscriptionID1
  client_id       = var.AzureClientID
  client_secret   = var.AzureClientSecret
  tenant_id       = var.AzureTenantID
}

```

Each Terraform config will presents itself with a file named **00_Authentication.tf**

Variable for the provider should be written in a secret file in case of a deployment in a pipeline.

```hcl

variable "AzureSubscriptionID" {
  type    = "string"
  default = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx"
}

variable "AzureClientID" {
  type    = "string"
  default = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxf"
}


variable "AzureClientSecret" {
  type    = "string"
  default = ""

}

variable "AzureTenantID" {
  type    = "string"
  default = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx"
}

```

It is also possible to remove default value and to use a tfvars file or terraform cli configuration to pass the sensible parameters.

For a simple deployment, use the authentication through az cli and comment the tf file




Login to azure, list the available subscription and select the one targeted for the deployment:

```powershell.js

az login -u <userlogin>
az account list --output table
az account set --subscription xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx

```


```hcl.js

provider "azurerm" {
  /*subscription_id = var.AzureSubscriptionID
  client_id       = var.AzureClientID
  client_secret   = var.AzureClientSecret
  tenant_id       = var.AzureTenantID*/
}

```




## Terraform backend configuration

As a best practice, use of remote backend is recommanded for terraform usage.
Azure Storage can be used as such backend.
Specify the azure storage account used as a backend, created previously, with variables value for the authentication in a file to be stored as secret in Azure Devops:


```hcl.js

terraform {
  backend "azurerm" {
    storage_account_name = "The name of the storage account"
    container_name       = "the name of the container"
    key                  = "name of the blob to store the backend"
    access_key           = "storageaccountaccesskey"
  }
}

```


### Prerequisite to use the code

#### Terraform

- Terraform code can be tested locally with only terraform installed on the station.
- Current version is Terraform 0.12.26.
- A app registration or a interactive logon on az cli is required to deploy the resource
- Defining a terraform.tfvars is required, as specified in the file terraform.tfvars.example



## This folder contains the terraform config to deploy the Azure automation resource used to managed the subscription


### 1. List of Azure resources deployed


|Resources type | Resources usage | Info | naming convention |
|---------------|:---------------:|:----:|------------------:|
|Resource Group | Group Log storage resources | N/A |applicationname-environment-rsg-role-index |
|Storage account | store the diagnostic log ofr diagnostic enabled resources | Located in the Resource Group for Logs | applicationnameenvironmentstaroleindex |


### 2. Terraform configuration deployment - terraform.tfvars


Fill in the terraform.tfvars to input the value of the variables

```hcl.js

######################################################################
# config variables 
######################################################################

AzureSubscriptionID                 = ""
AzureClientID                       = ""
AzureClientSecret                   = ""
AzureTenantID                       = ""



#Observability Basics variables
ASCPricingTier                      = "Standard"
IsDeploymentTypeGreenField           = true
ASCContactMail                      = ""
SubContactList                      = ""


```

### 3. Backend configuration

Specify the azure storage account used as a backend


```hcl.js

terraform {
  backend "azurerm" {
    storage_account_name = "The name of the storage account"
    container_name       = "the name of the container"
    key                  = "name of the blob to store the backend"
    access_key           = "storageaccountaccesskey"
  }
}


```

## Display after provisioning



