param name string
param location string
param envr string
var devakssubnetID = '/subscriptions/4a84c9d0-d7e4-4681-be42-dd358c9f1ea0/resourceGroups/krushna_dev_rg/providers/Microsoft.Network/virtualNetworks/dev_infra_vnet/subnets/dev_subnet_k8s'
var spnid = '39cfc2bd-9257-45f2-b3ad-d94f43b5f264'
var spnsecret = '7wW8Q~3cSZDgUEC3bcjSrrLJZKd3o7MAEYSP1aMI'


var aksconfigs = [
  {
    name: 'dev-aks-app01'
    sku: {
      name: 'Basic'
      tier : 'Paid'
    }
    aksversion: '1.27.0'
    addonProfiles: {}
    agentPoolProfiles : [
      {
        name: 'aks-nodepool-01'
        osDiskSizeGB: 256
        count: 5
        type: 'VirtualMachineScaleSets'
        vmSize: 'standard_d2s_v3'
        osType: 'Linux'
        osSKU: 'Ubuntu'
        upgradeSettings: {}
        mode: 'System'
        kubeletDiskType: 'OS'
        maxPods: 110
        vnetSubnetID: devakssubnetID
        osDiskType: 'Ephemeral'
        availabilityZones: ['1','2','3']
        maxCount: 10
        minCount: 2
        enableAutoScaling: true 
        powerState: { code: 'Running' }
        orchestratorVersion: '1.27.0'
        enableNodePublicIP: false 
        nodeLabels: {'aks-node-env': 'dev-aks-nodes'}
        // nodePublicIPPrefixID: 'test'
        // nodeTaints: [
        //   'test'
        // ]
        enableFIPS: false 
        enableEncryptionAtHost: false
        enableUltraSSD: false 
        
      }
    ]
    // apiServerAccessProfile: {
    //   authorizedIPRanges: [
    //     'string'
    //   ]
    // aadProfile: {
    //   adminGroupObjectIDs: [
    //     'string'
    //   ]
    servicePrincipalProfile: {
      clientId: spnid
      secret: spnsecret
    }
    enableRBAC: true 
    sshRSAPublicKeys : [loadTextContent('dev_ssh_key1.pem'), loadTextContent('dev_ssh_key2.pem')]
    publicNetworkAccess: 'Enabled'
    networkProfile: {
      ipFamilies: [
        'IPv4'
      ]
      loadBalancerProfile: {
        enableMultipleStandardLoadBalancers: true
        backendPoolType: 'nodeIPConfiguration'
      }
      loadBalancerSku: 'Standard'
      monitoring: {
        enabled: true
      }
      networkPlugin: 'kubenet'
      networkPolicy: 'calico'
      // podCidr: '192.168.0.0/16'
      podCidrs: [
        '192.168.0.0/16'
      ]
      // serviceCidr: '10.0.0.0/16'
      serviceCidrs: [
        '10.0.0.0/16'
      ]
      dockerBridgeCidr: '172.17.0.1/16'
      outbountType: 'userDefinedRouting'
    }
  }
]

module aks '../../Modules/AKS/AKS.bicep' = [ for aksconfig in aksconfigs: {
  name: aksconfig.name
  params:{
    name: aksconfig.name
    location: location
    sku: aksconfig.sku
    aksversion: aksconfig.aksversion  
    tags: {
      CreatedUsing: 'Bicep'
      CreatorBy: 'Krushna'
      Environment : envr
    }
    agentPoolProfiles: aksconfig.agentPoolProfiles
    sshRSAPublicKeys : aksconfig.sshRSAPublicKeys
    servicePrincipalProfile: aksconfig.servicePrincipalProfile
    enableRBAC: aksconfig.enableRBAC
    publicNetworkAccess: aksconfig.publicNetworkAccess
    networkProfile: aksconfig.networkProfile
  }
}]
