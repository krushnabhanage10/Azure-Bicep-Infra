param name string
param location string
param tags object
param sku object
param aksversion string
param agentPoolProfiles array
param sshRSAPublicKeys array
param servicePrincipalProfile object
param enableRBAC bool
param publicNetworkAccess string
param networkProfile object


resource aks 'Microsoft.ContainerService/managedClusters@2023-08-01' = {
  name: name
  location: location
  tags: tags
  sku : sku
  identity:{
    type: 'SystemAssigned'
  }
  properties:{
    kubernetesVersion: aksversion
    dnsPrefix: name
    agentPoolProfiles: agentPoolProfiles
    linuxProfile:{
      adminUsername: '${name}sshuser'
      ssh:{
        publicKeys: sshRSAPublicKeys
      }
    }
    servicePrincipalProfile: servicePrincipalProfile
    enableRBAC: enableRBAC 
    publicNetworkAccess: publicNetworkAccess
    networkProfile: networkProfile
  }

}

