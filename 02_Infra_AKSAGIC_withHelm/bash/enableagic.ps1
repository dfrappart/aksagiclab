$agwid = (az network application-gateway show -n agw-1 -g rsgagicmeetup -o tsv --query id)
az aks enable-addons -n aks-agic -g rsgagicmeetup -a ingress-appgw --appgw-id $agwid
 AAD role propagation done[############################################]  100.0000%{
  "aadProfile": {
    "adminGroupObjectIds": [
      "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
    ],
    "clientAppId": null,
    "enableAzureRbac": null,
    "managed": true,
    "serverAppId": null,
    "serverAppSecret": null,
    "tenantId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  },
  "addonProfiles": {
=========================================================
    "ingressApplicationGateway": {
      "config": {
        "applicationGatewayId": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsgagicmeetup/providers/Microsoft.Network/applicationGateways/agw-1",
        "effectiveApplicationGatewayId": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rsgagicmeetup/providers/Microsoft.Network/applicationGateways/agw-1"
      },
      "enabled": true,
      "identity": {
        "clientId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "objectId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "resourceId": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rsg-dfitcfr-lab-agic-aksobjects/providers/Microsoft.ManagedIdentity/userAssignedIdentities/ingressapplicationgateway-aks-agic"
      }
    },
==================================================================
  "agentPoolProfiles": [...],
  "apiServerAccessProfile": {...},
  "autoScalerProfile": {
    "balanceSimilarNodeGroups": "false",
    "expander": "random",
    "maxEmptyBulkDelete": "10",
    "maxGracefulTerminationSec": "600",
    "maxTotalUnreadyPercentage": "45",
    "newPodScaleUpDelay": "0s",
    "okTotalUnreadyCount": "3",
    "scaleDownDelayAfterAdd": "10m",
    "scaleDownDelayAfterDelete": "10s",
    "scaleDownDelayAfterFailure": "3m",
    "scaleDownUnneededTime": "10m",
    "scaleDownUnreadyTime": "20m",
    "scaleDownUtilizationThreshold": "0.5",
    "scanInterval": "10s",
    "skipNodesWithLocalStorage": "true",
    "skipNodesWithSystemPods": "true"
  },
  "diskEncryptionSetId": null,
  "dnsPrefix": "aksagiclab",
  "enablePodSecurityPolicy": null,
  "enableRbac": true,
  "fqdn": "aksagiclab-0111584d.hcp.westeurope.azmk8s.io",
  "id": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rsgagicmeetup/providers/Microsoft.ContainerService/managedClusters/aks-agic",
  "identity": {...},
  "identityProfile": {
    "kubeletidentity": {
      "clientId": "699d56ad-7c6e-43d0-91ff-eca821b228e3",
      "objectId": "dfa083bf-31a4-4bae-981a-81fa638c34c9",
      "resourceId": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rsg-dfitcfr-lab-agic-aksobjects/providers/Microsoft.ManagedIdentity/userAssignedIdentities/aks-agic-agentpool"
    }
  },
  "kubernetesVersion": "1.18.14",
  "linuxProfile": {...},
  "location": "westeurope",
  "maxAgentPools": 10,
  "name": "aks-agic",
  "networkProfile": {...},
  "nodeResourceGroup": "rsg-dfitcfr-lab-agic-aksobjects",
  "powerState": {...},
  "privateFqdn": null,
  "provisioningState": "Succeeded",
  "resourceGroup": "rsgagicmeetup",
  "servicePrincipalProfile": {...},
  "sku": {
    "name": "Basic",
    "tier": "Free"
  },
  "tags": {
    "CostCenter": "labaks",
    "Country": "fr",
    "Environment": "lab",
    "ManagedBy": "Terraform",
    "Project": "agic",
    "ResourceOwner": "That would be me"
  },
  "type": "Microsoft.ContainerService/ManagedClusters",
  "windowsProfile": null
}