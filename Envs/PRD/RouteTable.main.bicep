param name string
param location string
param envr string


var rtconfigs = [
  {
    name: 'prd_iaas_rt'
    disableBgpRoutePropagation: false 
    routes: [
      {
        name : 'prd_iaas_route'
        addressPrefix: '0.0.0.0/0'
        hasBgpOverride: false
        nextHopIpAddress: '0.0.0.0'
        nextHopType: 'VirtualAppliance'
      }
    ]
  }
  {
    name: 'prd_paas_rt'
    disableBgpRoutePropagation: false 
    routes: [
      {
        name : 'prd_k8s_route'
        addressPrefix: '0.0.0.0/0'
        hasBgpOverride: false
        nextHopIpAddress: '0.0.0.0'
        nextHopType: 'VirtualAppliance'
      }
    ]
  }
]



module rt '../../Modules/RouteTable/RouteTable.bicep' = [ for rtconfig in rtconfigs : {
  name: rtconfig.name
  params:{
    name:  rtconfig.name
    location: location
    tags: {
      CreatedUsing: 'Bicep'
      CreatorBy: 'Krushna'
      Environment : envr
    }
    disableBgpRoutePropagation : rtconfig.disableBgpRoutePropagation
    routes: rtconfig.routes
  }
}]
