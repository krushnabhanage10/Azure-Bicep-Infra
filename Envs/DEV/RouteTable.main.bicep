param name string
param location string
param envr string


var rtconfigs = [
  {
    name: 'dev_iaas_rt'
    disableBgpRoutePropagation: false 
    routes: [
      {
        name : 'dev_paas_route'
        addressPrefix: '0.0.0.0/0'
        hasBgpOverride: false
        nextHopIpAddress: '0.0.0.0'
        nextHopType: 'VirtualAppliance'
      }
    ]
  }
  {
    name: 'dev_iaas_rt'
    disableBgpRoutePropagation: false 
    routes: [
      {
        name : 'dev_k8s_route'
        addressPrefix: '0.0.0.0/0'
        hasBgpOverride: false
        nextHopIpAddress: '0.0.0.0'
        nextHopType: 'VirtualAppliance'
      }
    ]
  }
]



module rt '../../Modules/RouteTable/RouteTable.bicep' = [ for rtconfig in rtconfigs : {
  name: name
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
