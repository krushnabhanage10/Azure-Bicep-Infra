param name string
param location string
param envr string

var nwconfigs = [
  {
    name: 'dev_app_vnet'
    vnetaddressprefix : [ '40.0.0.0/22' ]
    subnets: [
      {
        name: 'dev_subnet_app'
        properties: {
          addressPrefix: '40.0.0.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'dev_subnet_db_sql'
        properties: {
          addressPrefix: '40.0.1.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'dev_subnet_db_mongo'
        properties: {
          addressPrefix: '40.0.2.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'dev_subnet_app_connections'
        properties: {
          addressPrefix: '40.0.3.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
  }
  {
    name: 'dev_infra_vnet'
    vnetaddressprefix : [ '40.0.4.0/22' ]
    subnets: [
      {
        name: 'dev_subnet_iaas'
        properties: {
          addressPrefix: '40.0.4.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'dev_subnet_paas'
        properties: {
          addressPrefix: '40.0.5.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'dev_subnet_k8s'
        properties: {
          addressPrefix: '40.0.6.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'dev_subnet_infra_connections'
        properties: {
          addressPrefix: '40.0.7.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
  }
]


module vnet '../../Modules/VirtualNetwork/VirtualNetwork.bicep' = [ for nwconfig in nwconfigs : {
  name: nwconfig.name
  params:{
    name: nwconfig.name
    location: location
    vnetaddressprefix : nwconfig.vnetaddressprefix
    subnets: nwconfig.subnets
    tags: {
      CreatedUsing: 'Bicep'
      CreatorBy: 'Krushna'
      Environment : envr
    }
  }
}]
