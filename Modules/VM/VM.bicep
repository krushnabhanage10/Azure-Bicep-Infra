param name string
param location string
param envr string
param tags object
param properties object
param nicname string
param subnetid string
param ipconfigname string
param publicIPAddressName string
param random string = toLower(uniqueString(publicIPAddressName))
param dnsLabelPrefix string = toLower('krushna${envr}${random}${uniqueString(resourceGroup().id)}')



resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: publicIPAddressName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    publicIPAddressVersion: 'IPv4'
    dnsSettings: {
      domainNameLabel: dnsLabelPrefix
    }
    idleTimeoutInMinutes: 4
  }
}


resource nic 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: nicname
  location: location
  properties: {
    ipConfigurations: [
      {
        name: ipconfigname
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddress.id
          }
          subnet: {
            id: subnetid
          }
        }
      }
    ]
  }
  dependsOn: [
    publicIPAddress
  ]
}




resource vm 'Microsoft.Compute/virtualMachines@2023-07-01' = {
  name: name
  location: location
  tags: tags
  // zones: [
  //   '1'
  //   '2'
  //   '3'
  // ]
  properties: properties
  dependsOn: [
    nic
  ]
}
