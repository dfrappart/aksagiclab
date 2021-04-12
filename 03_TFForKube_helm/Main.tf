######################################################################
# Webshop K8S + Storage resources
######################################################################

######################################################################
# Access to terraform
######################################################################

terraform {

  #backend "azurerm" {}
}

provider "azurerm" {
  subscription_id         = var.AzureSubscriptionID
  client_id               = var.AzureClientID
  client_secret           = var.AzureClientSecret
  tenant_id               = var.AzureTenantID

  features {}
}

/*
provider "kubernetes" {
  config_path    = var.kubepath
  config_context = var.kubecontext
}
*/
/*
provider "helm" {
  kubernetes {
    config_path         = var.kubepath
    config_context      = var.kubecontext
  }
}
*/

provider "kubernetes" {

  host                    = data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.host #module.AKSClus.KubeAdminCFG_HostName
  username                = data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.username
  password                = data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.password
  client_certificate      = base64decode(data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.client_certificate)
  client_key              = base64decode(data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.client_key)
  cluster_ca_certificate  = base64decode(data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.cluster_ca_certificate)

}


provider "helm" {
  kubernetes {

  host                    = data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.host #module.AKSClus.KubeAdminCFG_HostName
  username                = data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.username
  password                = data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.password
  client_certificate      = base64decode(data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.client_certificate)
  client_key              = base64decode(data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.client_key)
  cluster_ca_certificate  = base64decode(data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.cluster_ca_certificate)

  }
}

locals {

  ResourcePrefix                        = "${lower(var.Company)}${lower(var.CountryTag)}"

  HelmAGICConfig = {

      "set1" = {
        ParamName             = "verbosityLevel"
        ParamValue            = 3

    }
      "set2" = {
        ParamName             = "appgw.applicationGatewayID"
        ParamValue            = data.terraform_remote_state.AKSClus1.outputs.AGWId

    }
      "set3" = {
        ParamName             = "appgw.resourceGroup"
        ParamValue            = data.terraform_remote_state.AKSClus1.outputs.AGWRG

    }
      "set4" = {
        ParamName             = "rbac.enabled"
        ParamValue            = true

    }
      "set5" = {
        ParamName             = "armAuth.type"
        ParamValue            = "aadPodIdentity"

    }
      "set6" = {
        ParamName             = "armAuth.identityResourceID"
        ParamValue            = module.UAIAGIC.FullUAIOutput.id

    }
      "set7" = {
        ParamName             = "armAuth.identityClientId"
        ParamValue            = module.UAIAGIC.FullUAIOutput.client_id

    }
  }
}



######################################################################
# Creating a UAI for AGIC with contributor role on RG

module "UAIAGIC" {

  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules/Kube_UAI/"

  #Module variable
  UAISuffix                               = "agic"
  TargetLocation                          = data.azurerm_resource_group.AKSRG.location
  TargetRG                                = data.azurerm_resource_group.AKSRG.name
  RBACScope                               = data.azurerm_resource_group.AKSRG.id
  BuiltinRoleName                         = "Contributor"
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  Environment                             = var.Environment
  Project                                 = var.Project


}

######################################################################
# Associating route to agw subnet

resource "azurerm_subnet_route_table_association" "agwtoaksroutetable" {
  subnet_id                               = data.azurerm_subnet.AGWSubnet.id
  route_table_id                          = data.azurerm_subnet.AKSSubnet.route_table_id
}


######################################################################
# installing kured from helm

resource "helm_release" "kured" {
  name                                = "kured"
  repository                          = "https://weaveworks.github.io/kured"
  chart                               = "kured"
  version                             = var.kuredChartVer
  namespace                           = "kured"
  create_namespace                    = true

  dynamic "set" {
    for_each                          = var.HelmKuredParam
    iterator                          = each
    content {
      name                            = each.value.ParamName
      value                           = each.value.ParamValue
    }

  }

  set_sensitive {
    name                              = var.HelmKuredSensitiveParamName
    value                             = var.HelmKuredSensitiveParamValue
  }
}
######################################################################
# installing pod identity from helm

resource "helm_release" "podidentity" {
  name                                = "podidentity"
  repository                          = "https://raw.githubusercontent.com/Azure/aad-pod-identity/master/charts"
  chart                               = "aad-pod-identity"
  version                             = var.PodIdChartVer


  dynamic "set" {
    for_each                          = var.HelmPodIdentityParam
    iterator                          = each
    content {
      name                            = each.value.ParamName
      value                           = each.value.ParamValue
    }

  }

  depends_on = [
    helm_release.certmanager
  ]

}


######################################################################
# installing AGIC from helm

data "template_file" "agicyamlconfig" {
  template                                 = file("./template/agicyamlconfig.yaml")
  vars = {
    subid                                   = data.azurerm_subscription.current.subscription_id
    rgname                                  = data.azurerm_resource_group.AKSRG.name
    agicname                                = data.terraform_remote_state.AKSClus1.outputs.AGWName
    PodIdentityId                           = module.UAIAGIC.FullUAIOutput.id
    PodIdentityclientId                     = module.UAIAGIC.FullUAIOutput.client_id
    IsRBACEnabled                           = true
  }

}


resource "helm_release" "agic" {
  name                                = "agic"
  repository                          = "https://appgwingress.blob.core.windows.net/ingress-azure-helm-package/"
  chart                               = "ingress-azure"
  version                             = var.AgicChartVer
  namespace                           = "agic"
  create_namespace                    = true

  values = [data.template_file.agicyamlconfig.rendered]

  depends_on = [
    helm_release.podidentity
  ]


}



######################################################################
# installing CertManager from helm

resource "helm_release" "certmanager" {
  name                                = "cert-manager"
  repository                          = "https://charts.jetstack.io"
  chart                               = "cert-manager"
  version                             = var.CertMgmtChartVer
  namespace                           = "certmanager"
  create_namespace                    = true

  dynamic "set" {
    for_each                          = var.HelmCertManagerParam
    iterator                          = each
    content {
      name                            = each.value.ParamName
      value                           = each.value.ParamValue
    }

  }

  depends_on = [
    helm_release.kured
  ]

}
