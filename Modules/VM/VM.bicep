param name string
param location string
param tags object
param properties object
param nicname string
param subnetid string
param ipconfigname string

resource nic 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: nicname
  location: location
  properties: {
    ipConfigurations: [
      {
        name: ipconfigname
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          // publicIPAddress: {
          //   id: publicIp.id
          // }
          subnet: {
            id: subnetid
          }
        }
      }
    ]
  }
}




resource vm 'Microsoft.Compute/virtualMachines@2023-07-01' = {
  name: name
  location: location
  tags: tags
  zones: [
    '1'
  ]
  properties: properties
  dependsOn: [
    nic
  ]
}
