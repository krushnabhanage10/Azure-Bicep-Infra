param name string
param location string
param envr string

var nsgconfigs = [
    {
        name: 'prd_nsg_vms'
        securityrules : [
            {
                name: 'Allow_SSH_Port'
                properties: {
                  priority: 1000
                  protocol: 'Tcp'
                  access: 'Allow'
                  direction: 'Inbound'
                  sourceAddressPrefix: '*'
                  sourcePortRange: '*'
                  destinationAddressPrefix: '*'
                  destinationPortRange: '22'
                  sourcePortRanges: []
                  destinationPortRanges: []
                  sourceAddressPrefixes: []
                  destinationAddressPrefixes: []
                }
            }
            {
                name: 'Allow_RDP_Port'
                properties: {
                  priority: 1001
                  protocol: 'Tcp'
                  access: 'Allow'
                  direction: 'Inbound'
                  sourceAddressPrefix: '*'
                  sourcePortRange: '*'
                  destinationAddressPrefix: '*'
                  destinationPortRange: '3389'
                  sourcePortRanges: []
                  destinationPortRanges: []
                  sourceAddressPrefixes: []
                  destinationAddressPrefixes: []
                }
            }
            {
                name: 'Allow_HTTP_Port'
                properties: {
                    protocol: 'Tcp'
                    sourcePortRange: '*'
                    destinationPortRange: '80'
                    sourceAddressPrefix: '*'
                    destinationAddressPrefix: '*'
                    access: 'Allow'
                    priority: 1002
                    direction: 'Inbound'
                    sourcePortRanges: []
                    destinationPortRanges: []
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
        ]
    }
    {
        name: 'prd_nsg_k8s'
        securityrules : [
            {
                name: 'Allow_K8S_TLS_Port'
                properties: {
                    description: 'allow_kube_tls'
                    protocol: 'TCP'
                    sourcePortRange: '*'
                    destinationPortRange: '443'
                    sourceAddressPrefix: 'VirtualNetwork'
                    destinationAddressPrefix: '*'
                    access: 'Allow'
                    priority: 3891
                    direction: 'Inbound'
                    sourcePortRanges: []
                    destinationPortRanges: []
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
        ]
    }
]

module nsg '../../Modules/NSG/NSG.bicep' = [ for nsgconfig in nsgconfigs : {
  name: nsgconfig.name
  params:{
    name: nsgconfig.name
    location: location
    tags: {
      CreatedUsing: 'Bicep'
      CreatorBy: 'Krushna'
      Environment : envr
    }
    securityrules : nsgconfig.securityrules
  }
}]
