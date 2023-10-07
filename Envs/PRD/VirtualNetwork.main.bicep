param name string
param location string
param envr string

var nwconfigs = [
  {
    name: 'prd_app_vnet'
    vnetaddressprefix : [ '11.0.0.0/21' ]
    subnets: [
      {
        name: 'prd_subnet_app'
        properties: {
          addressPrefix: '11.0.0.0/22'
        }
      }
      {
        name: 'prd_subnet_db'
        properties: {
          addressPrefix: '11.0.4.0/22'
        }
      }
    ]
  }
  {
    name: 'prd_infra_vnet'
    vnetaddressprefix : [ '11.0.8.0/21' ]
    subnets: [
      {
        name: 'prd_subnet_iaas'
        properties: {
          addressPrefix: '11.0.8.0/22'
        }
      }
      {
        name: 'prd_subnet_paas'
        properties: {
          addressPrefix: '11.0.12.0/22'
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
