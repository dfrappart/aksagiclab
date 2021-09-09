##############################################################
#config variables
##############################################################

##############################################
#Variable for using subscription setup state as a data source

variable "SubsetupSTOAName" {
  type    = string
  description = "the name of the storage account storing the state of the 02 automation setup configuration"
}

variable "SubsetupContainerName" {
  type    = string
  description = "The name of the container in which the state is stored"
}

variable "SubsetupKey" {
  type    = string
  description = "The storage access key of the storage account"
}

variable "SubsetupAccessKey" {
  type    = string
  description = "the name of the file containing the state of the 02 Azure Autmation setup configuration"
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

variable "statekeyAKSClus1State" {
  type    = string
  description = "the name of the file containing the state of the 02 Azure Autmation setup configuration"
}

######################################################
#Tag related variables and naming convention section

variable "ResourceOwnerTag" {
  type          = string
  description   = "Tag describing the owner"
  default       = "That would be me"
}

variable "CountryTag" {
  type          = string
  description   = "Tag describing the Rexel Country"
  default       = "fr"
}

variable "CostCenterTag" {
  type          = string
  description   = "Tag describing the Cost Center"
  default       = "k8slab"
}

variable "Company" {
  type          = string
  description   = "The Company owner of the resources"
  default       = "dfitc"
}

variable "Project" {
  type          = string
  description   = "The name of the project"
  default       = "agic"
}

variable "Environment" {
  type          = string
  description   = "The environment, dev, prod..."
  default       = "lab"
}

##############################################################
#Variable declaration for provider azure

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

##############################################################
#Variable declaration for provider kube

variable "kubepath" {
  type                          = string
  description                   = "The Application secret"

}

variable "kubecontext" {
  type                          = string
  description                   = "The Azure AD tenant ID"
}

##############################################################
#Variable declaration for helm kured set

variable "kuredChartVer" {
  type                          = string
  description                   = "The version of the chart"
  default                       = "2.8.0"
}

variable "HelmKuredSensitiveParamName" {
  type                          = string
  description                   = "A parameter to send notification to teams" 
  default                       = "extraArgs.slack-hook-url"
}

variable "HelmKuredSensitiveParamValue" {
  type                          = string
  description                   = "The webhook that trigger the logic app responsible to send the notificaiton to teams" 

}

variable "HelmKuredParam" {
  type                  = map
  description            = "A map used to feed the dynamic blocks of the kured helm chart"
  default                = {

      "set1" = {
        ParamName             = "extraArgs.start-time"
        ParamValue            = "9am"

    }
      "set2" = {
        ParamName             = "extraArgs.end-time"
        ParamValue            = "5pm"

    }
      "set3" = {
        ParamName             = "extraArgs.time-zone"
        ParamValue            = "Europe/Paris"

    }
      "set4" = {
        ParamName             = "extraArgs.reboot-days"
        ParamValue            = "mon\\,tue\\,wed\\,thu\\,fri"

    }
      "set5" = {
        ParamName             = "tolerations[0].effect"
        ParamValue            = "NoSchedule"

    }
      "set6" = {
        ParamName             = "tolerations[0].key"
        ParamValue            = "role.kubernetes.io/master"

    }
      "set7" = {
        ParamName             = "tolerations[1].operator"
        ParamValue            = "Exists"

    }
      "set8" = {
        ParamName             = "tolerations[1].key"
        ParamValue            = "CriticalAddonsOnly"

    }
      "set9" = {
        ParamName             = "tolerations[2].operator"
        ParamValue            = "Exists"

    }
      "set10" = {
        ParamName             = "tolerations[2].effect"
        ParamValue            = "NoExecute"

    }
      "set11" = {
        ParamName             = "tolerations[3].operator"
        ParamValue            = "Exists"

    }
      "set12" = {
        ParamName             = "tolerations[3].effect"
        ParamValue            = "NoSchedule"

    }
  }

}

##############################################################
#Variable declaration for helm pod identity set

variable "PodIdChartVer" {
  type                          = string
  description                   = "The version of the chart"
  default                       = "4.1.3"
}

variable "HelmPodIdentityParam" {
  type                  = map
  description            = "A map used to feed the dynamic blocks of the pod identity helm chart"
  default                = {

      "set1" = {
        ParamName             = "nmi.allowNetworkPluginKubenet"
        ParamValue            = "true"

    }
      "set2" = {
        ParamName             = "installCRDs"
        ParamValue            = "true"

    }

  }

}

##############################################################
#Variable declaration for helm agic set

variable "AgicChartVer" {
  type                          = string
  description                   = "The version of the chart"
  default                       = "1.4.0"
}

##############################################################
#Variable declaration for helm cert manager set

variable "CertMgmtChartVer" {
  type                          = string
  description                   = "The version of the chart"
  default                       = "1.2.0"
}

variable "HelmCertManagerParam" {
  type                  = map
  description            = "A map used to feed the dynamic blocks of the cert manager helm chart"
  default                = {

      "set1" = {
        ParamName             = "installCRDs"
        ParamValue            = "true"

    }

  }

}

##############################################################
#Variable declaration for helm kubecost set

variable "kubecostChartVer" {
  type                          = string
  description                   = "The version of the chart"
  default                       = "1.84.0"
}

variable "HelmkubecostSensitiveParamName" {
  type                          = string
  description                   = "The parameter for the helm chart to define the token" 
  default                       = ""
}

variable "HelmKubeCostSensitiveParamValue" {
  type                          = string
  description                   = "The token value used by kubecost" 

}