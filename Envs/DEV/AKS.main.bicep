param name string
param location string
param envr string
var akssubnetid = '/subscriptions/4a84c9d0-d7e4-4681-be42-dd358c9f1ea0/resourceGroups/krushna_dev_rg/providers/Microsoft.Network/virtualNetworks/dev_infra_vnet/subnets/dev_subnet_k8s'
var spnid = '39cfc2bd-9257-45f2-b3ad-d94f43b5f264'
var spnsecret = '7wW8Q~3cSZDgUEC3bcjSrrLJZKd3o7MAEYSP1aMI'
var resource_group = 'krushna_dev_rg'

var aksconfigs = [
  {
    name: 'dev-aks-app01'
    sku: {
      name: 'Basic'
      tier: 'Paid'
    }
    aksversion: '1.27.3'
    agentPoolProfiles: [
      {
        name: 'nodepool01'
        count: 1
        vmSize: 'Standard_D2as_v4'
        osDiskSizeGB: 256
        osDiskType: 'Managed'
        kubeletDiskType: 'OS'
        vnetSubnetID: '/subscriptions/4a84c9d0-d7e4-4681-be42-dd358c9f1ea0/resourceGroups/krushna_dev_rg/providers/Microsoft.Network/virtualNetworks/dev_infra_vnet/subnets/dev_subnet_k8s'
        maxPods: 110
        type: 'VirtualMachineScaleSets'
        availabilityZones: [
          '1'
          '2'
        ]
        maxCount: 5
        minCount: 1
        enableAutoScaling: true
        powerState: {
          code: 'Running'
        }
        orchestratorVersion: '1.27.3'
        enableNodePublicIP: false
        nodeLabels: {
          'aks-node-env': 'dev-aks-nodes'
        }
        mode: 'System'
        enableEncryptionAtHost: false
        enableUltraSSD: false
        osType: 'Linux'
        osSKU: 'Ubuntu'
        upgradeSettings: {}
        enableFIPS: false
      }
    ]
    akssubnetid: akssubnetid
    linuxProfile: {
      adminUsername: 'dev-aks-app01sshuser'
      ssh: {
        publicKeys: [
          {
            keyData: loadTextContent('dev_ssh_key1.pem')
          }
        ]
      }
    }
    nodepoolname: 'nodepool01'
    nodecount: 1
    nodesku: 'Standard_D2as_v4'
    nodeosdisksize: 256
    nodedisktype: 'Managed'
    nodepooltype: 'VirtualMachineScaleSets'
    nodemaxcount: 5
    nodemincount: 1
    isautoscaling: true
    nodelabels:  {
      'aks-node-env': 'dev-aks-nodes'
    }
    servicePrincipalProfile: {
      clientId: spnid
      secret: spnsecret
    }
  }
  // {
  //   name: 'dev-aks-app02'
  //   sku: {
  //     name: 'Basic'
  //     tier: 'Paid'
  //   }
  //   aksversion: '1.27.3'
  //   agentPoolProfiles: [
  //     {
  //       name: 'nodepool01'
  //       count: 1
  //       vmSize: 'Standard_D2as_v4'
  //       osDiskSizeGB: 256
  //       osDiskType: 'Managed'
  //       kubeletDiskType: 'OS'
  //       vnetSubnetID: '/subscriptions/4a84c9d0-d7e4-4681-be42-dd358c9f1ea0/resourceGroups/krushna_dev_rg/providers/Microsoft.Network/virtualNetworks/dev_infra_vnet/subnets/dev_subnet_k8s'
  //       maxPods: 110
  //       type: 'VirtualMachineScaleSets'
  //       availabilityZones: [
  //         '1'
  //         '2'
  //       ]
  //       maxCount: 5
  //       minCount: 1
  //       enableAutoScaling: true
  //       powerState: {
  //         code: 'Running'
  //       }
  //       orchestratorVersion: '1.27.3'
  //       enableNodePublicIP: false
  //       nodeLabels: {
  //         'aks-node-env': 'dev-aks-nodes'
  //       }
  //       mode: 'System'
  //       enableEncryptionAtHost: false
  //       enableUltraSSD: false
  //       osType: 'Linux'
  //       osSKU: 'Ubuntu'
  //       upgradeSettings: {}
  //       enableFIPS: false
  //     }
  //   ]
  //   akssubnetid: akssubnetid
  //   linuxProfile: {
  //     adminUsername: 'dev-aks-app02sshuser'
  //     ssh: {
  //       publicKeys: [
  //         {
  //           keyData: loadTextContent('dev_ssh_key1.pem')
  //         }
  //       ]
  //     }
  //   }
  //   nodepoolname: 'nodepool01'
  //   nodecount: 1
  //   nodesku: 'Standard_D2as_v4'
  //   nodeosdisksize: 256
  //   nodedisktype: 'Managed'
  //   nodepooltype: 'VirtualMachineScaleSets'
  //   nodemaxcount: 5
  //   nodemincount: 1
  //   isautoscaling: true
  //   nodelabels:  {
  //     'aks-node-env': 'dev-aks-nodes'
  //   }
  //   servicePrincipalProfile: {
  //     clientId: spnid
  //     secret: spnsecret
  //   }
  // }
]

module aks '../../Modules/AKS/AKS.bicep' = [ for aksconfig in aksconfigs: {
  name: aksconfig.name
  params:{
    name: aksconfig.name
    location: location
    resource_group: name
    tags: {
      CreatedUsing: 'Bicep'
      CreatorBy: 'Krushna'
      Environment : envr
    }
    sku: aksconfig.sku
    aksversion: aksconfig.aksversion
    agentPoolProfiles: aksconfig.agentPoolProfiles
    akssubnetid: aksconfig.akssubnetid
    linuxProfile: aksconfig.linuxProfile
    nodepoolname: aksconfig.nodepoolname
    nodecount: aksconfig.nodecount
    nodesku: aksconfig.nodesku
    nodeosdisksize: aksconfig.nodeosdisksize
    nodedisktype: aksconfig.nodedisktype
    nodepooltype: aksconfig.nodepooltype
    nodemaxcount: aksconfig.nodemaxcount
    nodemincount: aksconfig.nodemincount
    isautoscaling: aksconfig.isautoscaling
    nodelabels: aksconfig.nodelabels
    servicePrincipalProfile : aksconfig.servicePrincipalProfile
  }
}]
