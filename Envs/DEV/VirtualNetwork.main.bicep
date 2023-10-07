param name string
param location string
param envr string

var nwconfigs = [
  {
    name: 'dev_app_vnet'
    vnetaddressprefix : [ '10.0.0.0/21' ]
    subnets: [
      {
        name: 'dev_subnet_app'
        properties: {
          addressPrefix: '10.0.0.0/22'
        }
      }
      {
        name: 'dev_subnet_db'
        properties: {
          addressPrefix: '10.0.4.0/22'
        }
      }
    ]
  }
  {
    name: 'dev_infra_vnet'
    vnetaddressprefix : [ '10.0.8.0/21' ]
    subnets: [
      {
        name: 'dev_subnet_iaas'
        properties: {
          addressPrefix: '10.0.8.0/22'
        }
      }
      {
        name: 'dev_subnet_paas'
        properties: {
          addressPrefix: '10.0.12.0/22'
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
