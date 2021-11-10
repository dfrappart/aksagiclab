######################################################
# Subscription Output

output "CurrentSubFullOutput" {

  value             = data.azurerm_subscription.current
}


######################################################
# AKS Cluster Output

output "AKSFullOutput" {

  value             = data.azurerm_kubernetes_cluster.AKSCluster
  sensitive         = true
}
