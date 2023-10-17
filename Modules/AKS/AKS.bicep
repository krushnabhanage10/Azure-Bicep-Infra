param name string
param location string
param resource_group string
param tags object
param sku object
param aksversion string
param agentPoolProfiles array
param akssubnetid string
param linuxProfile object
param nodepoolname string
param nodecount int
param nodesku string
param nodeosdisksize int
param nodedisktype string
param nodepooltype string
param nodemaxcount int
param nodemincount int
param isautoscaling bool
param nodelabels object
param servicePrincipalProfile object





resource aks_cluster 'Microsoft.ContainerService/managedClusters@2023-01-02-preview' = {
  name: name
  location: location
  tags: tags
  sku: sku
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    kubernetesVersion: aksversion
    dnsPrefix: name
    agentPoolProfiles: agentPoolProfiles
    linuxProfile: linuxProfile
    servicePrincipalProfile: servicePrincipalProfile
    nodeResourceGroup: 'MC_${resource_group}_${name}_${location}'
    enableRBAC: true
    networkProfile: {
      networkPlugin: 'kubenet'
      networkPolicy: 'calico'
      loadBalancerSku: 'Standard'
      loadBalancerProfile: {
        enableMultipleStandardLoadBalancers: true
        backendPoolType: 'nodeIPConfiguration'
      }
      podCidr: '192.168.0.0/16'
      serviceCidr: '10.0.0.0/16'
      dnsServiceIP: '10.0.0.10'
      outboundType: 'loadBalancer'
      podCidrs: [
        '192.168.0.0/16'
      ]
      serviceCidrs: [
        '10.0.0.0/16'
      ]
      ipFamilies: [
        'IPv4'
      ]
    }
    autoScalerProfile: {
      'balance-similar-node-groups': 'false'
      expander: 'random'
      'max-empty-bulk-delete': '10'
      'max-graceful-termination-sec': '600'
      'max-node-provision-time': '15m'
      'max-total-unready-percentage': '45'
      'new-pod-scale-up-delay': '0s'
      'ok-total-unready-count': '3'
      'scale-down-delay-after-add': '10m'
      'scale-down-delay-after-delete': '10s'
      'scale-down-delay-after-failure': '3m'
      'scale-down-unneeded-time': '10m'
      'scale-down-unready-time': '20m'
      'scale-down-utilization-threshold': '0.5'
      'scan-interval': '10s'
      'skip-nodes-with-local-storage': 'false'
      'skip-nodes-with-system-pods': 'true'
    }
    autoUpgradeProfile: {
      nodeOSUpgradeChannel: 'NodeImage'
    }
    storageProfile: {
      diskCSIDriver: {
        enabled: true
        version: 'v1'
      }
      fileCSIDriver: {
        enabled: true
      }
      snapshotController: {
        enabled: true
      }
    }
    publicNetworkAccess: 'Enabled'
    oidcIssuerProfile: {
      enabled: false
    }
  }
}

resource aks_nodepools 'Microsoft.ContainerService/managedClusters/agentPools@2023-01-02-preview' = {
  parent: aks_cluster
  name: nodepoolname
  properties: {
    count: nodecount
    vmSize: nodesku
    osDiskSizeGB: nodeosdisksize
    osDiskType: nodedisktype
    kubeletDiskType: 'OS'
    vnetSubnetID: akssubnetid
    maxPods: 110
    type: nodepooltype
    availabilityZones: [
      '1'
      '2'
    ]
    maxCount: nodemaxcount
    minCount: nodemincount
    enableAutoScaling: isautoscaling
    powerState: {
      code: 'Running'
    }
    orchestratorVersion: aksversion
    enableNodePublicIP: false
    nodeLabels: nodelabels
    mode: 'System'
    enableEncryptionAtHost: false
    enableUltraSSD: false
    osType: 'Linux'
    osSKU: 'Ubuntu'
    upgradeSettings: {}
    enableFIPS: false
  }
}
