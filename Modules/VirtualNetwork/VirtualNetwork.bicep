param name string
param location string
param vnetaddressprefix array
param subnets array
param tags object



resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: vnetaddressprefix
    }
    subnets: subnets
  }
}
